package net.i2p.router.tunnel;

import net.i2p.data.Hash;
import net.i2p.data.TunnelId;
import net.i2p.data.i2np.I2NPMessage;
import net.i2p.data.i2np.TunnelDataMessage;
import net.i2p.router.RouterContext;
import net.i2p.util.Log;

/**
 * We are the end of an outbound tunnel that we did not create.  Gather fragments
 * and honor the instructions as received.
 *
 */
public class OutboundTunnelEndpoint {
    private RouterContext _context;
    private Log _log;
    private HopConfig _config;
    private HopProcessor _processor;
    private FragmentHandler _handler;
    private OutboundMessageDistributor _outDistributor;

    public OutboundTunnelEndpoint(RouterContext ctx, HopConfig config, HopProcessor processor) {
        _context = ctx;
        _log = ctx.logManager().getLog(OutboundTunnelEndpoint.class);
        _config = config;
        _processor = processor;
        _handler = new RouterFragmentHandler(ctx, new DefragmentedHandler());
        _outDistributor = new OutboundMessageDistributor(ctx, 200);
    }
    public void dispatch(TunnelDataMessage msg, Hash recvFrom) {
        _config.incrementProcessedMessages();
        boolean ok = _processor.process(msg.getData(), 0, msg.getData().length, recvFrom);
        if (!ok) {
            // invalid IV
            // If we pass it on to the handler, it will fail
            // If we don't, the data buf won't get released from the cache... that's ok
            if (_log.shouldLog(Log.WARN))
                _log.warn("Invalid IV, dropping at OBEP " + _config);
            _context.statManager().addRateData("tunnel.corruptMessage", 1, 1);
            return;
        }
        _handler.receiveTunnelMessage(msg.getData(), 0, msg.getData().length);
    }
    
    private class DefragmentedHandler implements FragmentHandler.DefragmentedReceiver {
        public void receiveComplete(I2NPMessage msg, Hash toRouter, TunnelId toTunnel) {
            if (_log.shouldLog(Log.DEBUG))
                _log.debug("outbound tunnel " + _config + " received a full message: " + msg
                           + " to be forwarded on to "
                           + (toRouter != null ? toRouter.toBase64().substring(0,4) : "")
                           + (toTunnel != null ? ":" + toTunnel.getTunnelId() : ""));
            // don't drop it if we are the target
            if ((!_context.routerHash().equals(toRouter)) &&
                _context.tunnelDispatcher().shouldDropParticipatingMessage("OBEP " + msg.getType(), msg.getMessageSize()))
                return;
            _config.incrementSentMessages();
            _outDistributor.distribute(msg, toRouter, toTunnel);
        }
    }
}
