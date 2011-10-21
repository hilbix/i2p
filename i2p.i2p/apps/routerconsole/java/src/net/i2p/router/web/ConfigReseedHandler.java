package net.i2p.router.web;

import java.util.HashMap;
import java.util.Map;

import net.i2p.router.networkdb.reseed.Reseeder;

/**
 *  @since 0.8.3
 */
public class ConfigReseedHandler extends FormHandler {
    private Map _settings;
    
    @Override
    protected void processForm() {

        if (_action.equals(_("Save changes and reseed now"))) {
            saveChanges();
            boolean reseedInProgress = Boolean.valueOf(System.getProperty("net.i2p.router.web.ReseedHandler.reseedInProgress")).booleanValue();
            if (reseedInProgress) {
                addFormError(_("Reseeding is already in progress"));
            } else {
                // skip the nonce checking in ReseedHandler
                addFormNotice(_("Starting reseed process"));
                (new ReseedHandler(_context)).requestReseed();
            }
            return;
        }
        if (_action.equals(_("Save changes"))) {
            saveChanges();
            return;
        }
        addFormError(_("Unsupported") + ' ' + _action + '.');
    }
    
    public void setSettings(Map settings) { _settings = new HashMap(settings); }

    /** curses Jetty for returning arrays */
    private String getJettyString(String key) {
        String[] arr = (String[]) _settings.get(key);
        if (arr == null)
            return null;
        return arr[0].trim();
    }

    /** @since 0.8.9 */
    private void saveString(String config, String param) {
        String val = getJettyString(param);
        if (val != null && val.length() > 0)
            _context.router().setConfigSetting(config, val);
        else
            _context.router().removeConfigSetting(config);
    }

    /** @since 0.8.9 */
    private void saveBoolean(String config, String param) {
        boolean val = getJettyString(param) != null;
        _context.router().setConfigSetting(config, Boolean.toString(val));
    }

    private void saveChanges() {
        saveString(Reseeder.PROP_PROXY_PORT, "port");
        saveString(Reseeder.PROP_PROXY_HOST, "host");
        saveString(Reseeder.PROP_PROXY_USERNAME, "username");
        saveString(Reseeder.PROP_PROXY_PASSWORD, "password");
        saveBoolean(Reseeder.PROP_PROXY_AUTH_ENABLE, "auth");
        saveString(Reseeder.PROP_SPROXY_PORT, "sport");
        saveString(Reseeder.PROP_SPROXY_HOST, "shost");
        saveString(Reseeder.PROP_SPROXY_USERNAME, "susername");
        saveString(Reseeder.PROP_SPROXY_PASSWORD, "spassword");
        saveBoolean(Reseeder.PROP_SPROXY_AUTH_ENABLE, "sauth");
        String url = getJettyString("reseedURL");
        if (url != null)
            _context.router().setConfigSetting(Reseeder.PROP_RESEED_URL, url.trim().replace("\r\n", ",").replace("\n", ","));
        String mode = getJettyString("mode");
        boolean req = "1".equals(mode);
        boolean disabled = "2".equals(mode);
        _context.router().setConfigSetting(Reseeder.PROP_SSL_REQUIRED,
                                           Boolean.toString(req));
        _context.router().setConfigSetting(Reseeder.PROP_SSL_DISABLE,
                                           Boolean.toString(disabled));
        saveBoolean(Reseeder.PROP_PROXY_ENABLE, "enable");
        saveBoolean(Reseeder.PROP_SPROXY_ENABLE, "senable");
        _context.router().saveConfig();
        addFormNotice(_("Configuration saved successfully."));
    }
}
