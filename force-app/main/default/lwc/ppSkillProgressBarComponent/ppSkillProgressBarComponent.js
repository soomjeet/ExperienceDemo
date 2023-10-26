import { LightningElement, api } from 'lwc';

export default class PpSkillProgressBarComponent extends LightningElement {
    _progressBarPillData = {
        skillName: "Test",
        skillProgress: "3.5"
    }

    @api
    get progressBarPillData() {
        return this._progressBarPillData;
    }
    set progressBarPillData(value) {
        this._progressBarPillData = value;
    }

    get skillProgressValue() {
        let skillProgressBarWidth = this._progressBarPillData?.skillProgress ? this._progressBarPillData?.skillProgress * 10 : 0;
        return skillProgressBarWidth;
    }
}