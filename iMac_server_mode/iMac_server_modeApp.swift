//
//  iMac_server_modeApp.swift
//  iMac_server_mode or Dell 3443 server mode (2023-12-23)
//
//  Created by viettronics868 on 2023-10-25.
//
/* I have an 2007 iMac installed Ubuntu 20.04 (or Dell 3443 w/Ubuntu 22.04). Now I want to build a smart TV with this iMac. My goal is after receiving electric source, the iMac  should act like server-mode mean it will automatically boot. This is the work instruction for my project:
 - Step 1: identify the southbridge chipset with the command
                $ lspci | grep LPC
             + for my 2007 iMac the result is 00:1f.0 ISA bridge: INTEL corporation 82801HM (ICH8M) LPC Interface Controller (rev 03)
             + for Dell 3443 the result is 00:1f.0 ISA bridge: Intel Corporation Wildcat Point-LP LPC Controller (rev 03)
             + I use 00:1f.0 (a.k.a bus:device.function) for the next step
             + I looked for the datasheet of 82801HM (ICH8M) and identified the controller bit named AFTERG3_EN belong to the register 0xa4. That is what I want. The value of AFTER3G_EN is 0 mean server-mode.
 - Step 2: create a service call boot_on_power_apply.service
            + use the command $ cd /etc/systemd/system
            + use the command $ touch boot_on_power_apply.service
            + use the command $sudo nano boot_on_power_apply.service
            + add these lines of commands into the service:
                    [Unit]
                    Description=boot iMac after power applied
                    [Service]
                    Type=oneshot
 
                    # I leave information of other mac systems here just in case
 
                    # reboot register for Mac Mini with nVidia ISA bridge (just in case)
                    # ExecStart=setpci -s 00:03.0 0x7b.b=0x19 //uncomment when using

                    # reboot register for 2007 iMac or Mac Mini or Dell 3443 with Intel ISA bridge
                    ExecStart=sudo setpci -s 0:1f.0 0xa4.b=0

                    # reboot register for PPC Mac Mini (just in case):
                    # ExecStart=echo server_mode=1 > /proc/pmu/options //uncomment when using


                    [Install]
                    WantedBy=sysinit.target
            + save (Ctrl+S) and exit (Ctrl+X) and run the service using the command:
                    $ sudo systemctl enable --now boot_on_power_apply.service
 - Step 3: shut down iMac (or Dell 3443) and stop power source, then start power source again, and welcome to server mode on iMac!
NOTE: this project does not involve any line of code as below. I had to create the swift files since Xcode needs that.
            Please understand! Thank for visiting my github!
 
 */



import SwiftUI

@main
struct iMac_server_modeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
