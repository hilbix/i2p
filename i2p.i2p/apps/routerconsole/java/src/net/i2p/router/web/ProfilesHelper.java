package net.i2p.router.web;

import java.io.IOException;


public class ProfilesHelper extends HelperBase {
    private boolean _full;

    public ProfilesHelper() {}
    
    public void setFull(String f) {
        _full = f != null;
    }

    /** @return empty string, writes directly to _out */
    public String getProfileSummary() {
        try {
            ProfileOrganizerRenderer rend = new ProfileOrganizerRenderer(_context.profileOrganizer(), _context);
            rend.renderStatusHTML(_out, _full);
        } catch (IOException ioe) {
            ioe.printStackTrace();
        }
        return "";
    }
    
    /** @return empty string, writes directly to _out */
    public String getShitlistSummary() {
        try {
            ShitlistRenderer rend = new ShitlistRenderer(_context);
            rend.renderStatusHTML(_out);
        } catch (IOException ioe) {
            ioe.printStackTrace();
        }
        return "";
    }
}
