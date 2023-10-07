import { LightningElement } from 'lwc';
import FORM_FACTOR from '@salesforce/client/formFactor';
import DESKTOPTEMPLATE from "./ppageComponentDesktop.html";
import MOBILETEMPLATE from "./ppageComponentMobile.html";
import SUMMARY_LABEL from '@salesforce/label/c.pp_Summary_Section_Label';
import getExperiencesData from '@salesforce/apex/PortfolioProfileController.getExperiences';

const SUMMARY_SECTION_NAME = "summary_section";
const EXPERIENCE_SECTION_NAME = "experience_section";
const SKILLS_SECTION_NAME = "skills_section";
export default class PpageComponent extends LightningElement {
    
    _isMobileScreen = false;
    activeSections = [SUMMARY_SECTION_NAME,EXPERIENCE_SECTION_NAME,SKILLS_SECTION_NAME];
    label = {
        SUMMARY_LABEL
    };
    connectedCallback() {
        console.log("--- Connected Callback ---");

        getExperiencesData()
          .then(result => {
            console.log('Result', JSON.stringify(result));
          })
          .catch(error => {
            console.error('Error:', error);
        });
    }

    render(){
        this._isMobileScreen = FORM_FACTOR === "Small";
        if (!this._isMobileScreen) {
            return DESKTOPTEMPLATE;
        }
        else{
            return MOBILETEMPLATE;
        }
    }
}