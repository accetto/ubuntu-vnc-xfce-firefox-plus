// spell-checker: disable

// Issue: Firefox tab crashes "Gah. Your tab just crashed."
// Mitigate the tab crashing problem by forcing the following preferences:
// user_pref("browser.tabs.remote.autostart", false);
// user_pref("browser.tabs.remote.autostart.2", false);
// Moved to 'user.js' so the users can control it.

// Add the preferences you want to force administratively here.
// The preferences will be forced for each session in all profiles.
// The VNC user ('headless:headless' by default) gets permissions to modify this file.
