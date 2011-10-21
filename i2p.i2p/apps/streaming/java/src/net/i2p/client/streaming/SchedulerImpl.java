package net.i2p.client.streaming;

import net.i2p.I2PAppContext;
import net.i2p.util.Log;
import net.i2p.util.SimpleScheduler;

/**
 * Base scheduler
 */
abstract class SchedulerImpl implements TaskScheduler {
    protected I2PAppContext _context;
    private Log _log;
    
    public SchedulerImpl(I2PAppContext ctx) {
        _context = ctx;
        _log = ctx.logManager().getLog(SchedulerImpl.class);
    }
    
    protected void reschedule(long msToWait, Connection con) {
        SimpleScheduler.getInstance().addEvent(con.getConnectionEvent(), msToWait);
    }
}
