import { Component } from '@angular/core';
/*
import {
  Plugins,
  PushNotification,
  PushNotificationToken,
  PushNotificationActionPerformed } from '@capacitor/core';
*/
import {
  Plugins,
  PushNotification,
  PushNotificationToken,
  PushNotificationActionPerformed } from '@capacitor/core';

const { PushNotifications } = Plugins;

declare var Capacitor;
const { AppierPlugin } = Capacitor.Plugins;

@Component({
  selector: 'app-tabs',
  templateUrl: 'tabs.page.html',
  styleUrls: ['tabs.page.scss']
})
export class TabsPage {

  constructor() {

    console.log(AppierPlugin);
    AppierPlugin.configure({appId:"9cce3dd2bb98c0dad844",
    appGroup:"group.com.appier.AIQUA.notification", isDev: true});


    //
    // Request permission to use push notifications
        // iOS will prompt user and return if they granted permission or not
        // Android will just grant without prompting
        /*
        PushNotifications.requestPermission().then( result => {
          if (result.granted) {
            // Register with Apple / Google to receive push via APNS/FCM
            PushNotifications.register();
          } else {
            // Show some error
          }
        });

        PushNotifications.addListener('registration',
          (token: PushNotificationToken) => {
            // alert('Push registration success, token: ' + token.value);
            AppierPlugin.logEvent({eventName:'Push registration success, token: ' + token.value});
            // AppierPlugin.logEvent({eventName: token.value});
            // AppierPluginPlugin.setToken({token: token.value});
          }
        );

        PushNotifications.addListener('registrationError',
          (error: any) => {
            alert('Error on registration: ' + JSON.stringify(error));
          }
        );

        PushNotifications.addListener('pushNotificationReceived',
          (notification: PushNotification) => {
            alert('Push received: ' + JSON.stringify(notification));
          }
        );

        PushNotifications.addListener('pushNotificationActionPerformed',
          (notification: PushNotificationActionPerformed) => {
            alert('Push action performed: ' + JSON.stringify(notification));
          }
        );
        */
    //

  }

}
