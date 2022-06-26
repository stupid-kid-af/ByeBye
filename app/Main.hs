{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.GI.Base
import qualified GI.Gtk as Gtk
import System.Directory
import System.Process
import System.Posix.User

main :: IO ()
main = do
    Gtk.init Nothing

    win <- Gtk.windowNew Gtk.WindowTypeToplevel
    Gtk.setContainerBorderWidth win 10
    Gtk.setWindowTitle win "ByeBye"
    Gtk.setWindowResizable win False
    Gtk.setWindowDefaultWidth win 750
    Gtk.setWindowDefaultHeight win 225
    Gtk.setWindowWindowPosition win Gtk.WindowPositionCenter
    Gtk.windowSetDecorated win False

    home <- getHomeDirectory
    user <- getEffectiveUserName

    img1 <- Gtk.imageNewFromFile $ home ++ "/Documents/gui/haskell-gtk/byebye/img/cancel.png"
    img2 <- Gtk.imageNewFromFile $ home ++ "/Documents/gui/haskell-gtk/byebye/img/logout.png"
    img3 <- Gtk.imageNewFromFile $ home ++ "/Documents/gui/haskell-gtk/byebye/img/reboot.png"
    img4 <- Gtk.imageNewFromFile $ home ++ "/Documents/gui/haskell-gtk/byebye/img/shutdown.png"
    img5 <- Gtk.imageNewFromFile $ home ++ "/Documents/gui/haskell-gtk/byebye/img/suspend.png"
    img6 <- Gtk.imageNewFromFile $ home ++ "/Documents/gui/haskell-gtk/byebye/img/hibernate.png"
    img7 <- Gtk.imageNewFromFile $ home ++ "/Documents/gui/haskell-gtk/byebye/img/lock.png"


    label1 <- Gtk.labelNew Nothing
    Gtk.labelSetMarkup label1 "<b>Cancel</b>"

    label2 <- Gtk.labelNew Nothing
    Gtk.labelSetMarkup label2 "<b>Logout</b>"

    label3 <- Gtk.labelNew Nothing
    Gtk.labelSetMarkup label3 "<b>Reboot</b>"

    label4 <- Gtk.labelNew Nothing
    Gtk.labelSetMarkup label4 "<b>Shutdown</b>"

    label5 <- Gtk.labelNew Nothing
    Gtk.labelSetMarkup label5 "<b>Suspend</b>"

    label6 <- Gtk.labelNew Nothing
    Gtk.labelSetMarkup label6 "<b>Hibernate</b>"

    label7 <- Gtk.labelNew Nothing
    Gtk.labelSetMarkup label7 "<b>Lock</b>"


    btn1 <- Gtk.buttonNew
    Gtk.buttonSetRelief btn1 Gtk.ReliefStyleNone
    Gtk.buttonSetImage btn1 $ Just img1
    Gtk.widgetSetHexpand btn1 False
    on btn1 #clicked $ do
        putStrLn "Use chose: Cancel"
        Gtk.widgetDestroy win

    btn2 <- Gtk.buttonNew
    Gtk.buttonSetRelief btn2 Gtk.ReliefStyleNone
    Gtk.buttonSetImage btn2 $ Just img2
    Gtk.widgetSetHexpand btn2 False
    on btn2 #clicked $ do
        putStrLn "Use chose: Logout"
        callCommand $ "pkill -u " ++ user

    btn3 <- Gtk.buttonNew
    Gtk.buttonSetRelief btn3 Gtk.ReliefStyleNone
    Gtk.buttonSetImage btn3 $ Just img3
    Gtk.widgetSetHexpand btn3 False
    on btn3 #clicked $ do
        putStrLn "Use chose: Reboot"
        callCommand "reboot"

    btn4 <- Gtk.buttonNew
    Gtk.buttonSetRelief btn4 Gtk.ReliefStyleNone
    Gtk.buttonSetImage btn4 $ Just img4
    Gtk.widgetSetHexpand btn4 False
    on btn4 #clicked $ do
        putStrLn "Use chose: Shutdown"
        callCommand "shutdown -h now"

    btn5 <- Gtk.buttonNew
    Gtk.buttonSetRelief btn5 Gtk.ReliefStyleNone
    Gtk.buttonSetImage btn5 $ Just img5
    Gtk.widgetSetHexpand btn5 False
    on btn5 #clicked $ do
        putStrLn "Use chose: Suspend"
        callCommand "systemctl suspend"

    btn6 <- Gtk.buttonNew
    Gtk.buttonSetRelief btn6 Gtk.ReliefStyleNone
    Gtk.buttonSetImage btn6 $ Just img6
    Gtk.widgetSetHexpand btn6 False
    on btn6 #clicked $ do
        putStrLn "Use chose: Hibernate"
        callCommand "systemctl hibernate"


    btn7 <- Gtk.buttonNew
    Gtk.buttonSetRelief btn7 Gtk.ReliefStyleNone
    Gtk.buttonSetImage btn7 $ Just img7
    Gtk.widgetSetHexpand btn7 False
    on btn7 #clicked $ do
        putStrLn "Use chose: Lock"
        callCommand "slock"

    grid <- Gtk.gridNew
    Gtk.gridSetColumnSpacing grid 10
    Gtk.gridSetRowSpacing grid 10
    Gtk.gridSetColumnHomogeneous grid True

    #attach grid btn1   0 0 1 1
    #attach grid label1 0 1 1 1
    #attach grid btn2   1 0 1 1
    #attach grid label2 1 1 1 1
    #attach grid btn3   2 0 1 1
    #attach grid label3 2 1 1 1
    #attach grid btn4   3 0 1 1
    #attach grid label4 3 1 1 1
    #attach grid btn5   4 0 1 1
    #attach grid label5 4 1 1 1
    #attach grid btn6   5 0 1 1
    #attach grid label6 5 1 1 1
    #attach grid btn7   6 0 1 1
    #attach grid label7 6 1 1 1
    #add win grid

    Gtk.onWidgetDestroy win Gtk.mainQuit
    #showAll win
    Gtk.main
