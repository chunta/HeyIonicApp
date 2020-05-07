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
const { HeyAiquaIonicPlugin } = Capacitor.Plugins;

@Component({
  selector: 'app-tabs',
  templateUrl: 'tabs.page.html',
  styleUrls: ['tabs.page.scss']
})
export class TabsPage {

  constructor() {

    console.log(HeyAiquaIonicPlugin);
    HeyAiquaIonicPlugin.echo({value:"9cce3dd2bb98c0dad844"});
    HeyAiquaIonicPlugin.start({appid:"9cce3dd2bb98c0dad844"});
    HeyAiquaIonicPlugin.log({name:"im event."});

    //
    // Request permission to use push notifications
        // iOS will prompt user and return if they granted permission or not
        // Android will just grant without prompting
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
            alert('Push registration success, token: ' + token.value);
            HeyAiquaIonicPlugin.log({name: token.value});
            HeyAiquaIonicPlugin.setToken({token: token.value});
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
    //

  }

}
