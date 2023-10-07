import { LightningElement } from 'lwc';
// import IMAGES from "@salesforce/resourceUrl/test";
// import backgroundUrl from '@salesforce/resourceUrl/BG_Img';
export default class PpageOverview extends LightningElement {

    portfolioImage = IMAGES;

    get backgroundStyle() {
        // return `background-image:url(${backgroundUrl})`;
    }

}