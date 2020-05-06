import { Component } from '@angular/core';
import {
  Plugins,
  PushNotification,
  PushNotificationToken,
  PushNotificationActionPerformed } from '@capacitor/core';
//import { HeyAiquaIonicPlugin } from 'heyaiquaionicplugin';
//import { heyheyplugin} from 'heyheyplugin';

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
    
  }

}
