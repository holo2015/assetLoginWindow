#!/bin/bash
loginBanner="Maryland Institute College of Art"

if [ -f "/Library/Preferences/com.poleposition-sw.lanrev_agent.plist" ]
  then
        if [ -f "/Library/MICA/edu.mica.deploy.plist" ]
        then
            Institution=`defaults read /Library/MICA/edu.mica.deploy Institution`;
            if [[ $Institution != "" ]]
            then
                loginBanner="${Institution}"
            fi
        fi
        outputtext="${loginBanner}
";

        NeedsSep=NO;

        MachineName=`defaults read /Library/Preferences/com.poleposition-sw.lanrev_agent SavedMachineName`;
        Building=`defaults read /Library/Preferences/com.poleposition-sw.lanrev_agent UserInfo0`;
        RoomNumber=`defaults read /Library/Preferences/com.poleposition-sw.lanrev_agent UserInfo1`;
        Department=`defaults read /Library/Preferences/com.poleposition-sw.lanrev_agent UserInfo2`;
        MachineNumber=`defaults read /Library/Preferences/com.poleposition-sw.lanrev_agent UserInfo5`;


        if [[ $Department != "" ]]
        then
                outputtext="${outputtext}${Department}";
                NeedsSep=YES
        fi
        if [[ $Building != "" ]]
        then
                if [[ $NeedsSep == "YES" ]]; then
                        outputtext="${outputtext} | "
                fi
                outputtext="${outputtext}${Building}";
                NeedsSep=YES
        fi
        if [[ $RoomNumber != "" ]]
        then
                if [[ $NeedsSep == "YES" ]]; then
                        outputtext="${outputtext} | "
                fi
                outputtext="${outputtext}${RoomNumber}";
        fi
        
        if [[ $MachineNumber != "" ]]
        then
                outputtext="${outputtext} | Machine #${MachineNumber}";
        fi
        
        outputtext="${outputtext}
${MachineName}";

        currentLoginText=`defaults read /Library/Preferences/com.apple.loginwindow LoginwindowText`;

        if [[ $currentLoginText != $outputtext ]]
        then
                defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText \""${outputtext}\"";

        fi
else
        echo "AM Agent not installed"
fi
