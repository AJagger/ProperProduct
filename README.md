# Proper Product

## About
Are you fed up of playing 6v6 matches on koth_product where the only two players on the server having fun are the snipers? Well, Proper Product is for you. Add this plugin to your server and everytime a sniper uses a rifle they will self-destruct.

The best part? The plugin will detect when the server changes to various versions of koth_product and will automatically activate. No need to toggle it on and off manually.

## Installation instructions:

Plugin installation:
* Paste the contents of the "addons" folder into the "tf2/tf/addons" folder found in the tf2 server installation.

## Configuration & Commands:

The following command can be used to check whether the plugin is currently active:
* pproduct_active

## Disclaimer

Yes, this plugin is just a bit of fun. No, you **shouldn't** use it for competitive matches.

...Althooooough, if you *were* to want to use it on a competitive server, adding it to the list of plugins automatically loaded and unloaded by SOAP-TF2DM will allow it to be present during pregame but completely removed when players ready up.
* Add "sm plugins unload properproduct" to the "soap_live.cfg" config file and "sm plugins load properproduct" to the "soap_notlive.cfg" config file. (**Requires SOAP Tournament**)

---

Based on code written for Proper Pregame (https://github.com/AJagger/ProperPregame), an actually serious plugin to make pregame better.
