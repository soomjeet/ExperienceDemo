
global with sharing class BlockFileDownloadEventCondition implements TxnSecurity.EventCondition {

	public boolean evaluate(SObject event) {
        system.debug('event  >> '+event);
		switch on event {
			when FileEventStore fileEvt {
				System.debug('Evaluating an fileEvt');
				return preventBaseProfilesFromDownloadingFiles(fileEvt);
			}
			when null {
                System.debug('Evaluating null');
                return false;   
            }
			when else {
				System.debug('Evaluating another event type: ' + event);
                return false;
			}
		}
	}

	private boolean preventBaseProfilesFromDownloadingFiles(FileEventStore fileEvt){
		System.debug('Inside preventBaseProfilesFromDownloadingFiles');
		System.debug(fileEvt);
		
		User currentInitiatedUser = [SELECT Id,Name,Profile.Name FROM USER WHERE Id =: fileEvt.UserId WITH SECURITY_ENFORCED LIMIT 01];

		if(fileEvt.FileAction.equalsIgnoreCase('UI_DOWNLOAD') 
		&& currentInitiatedUser.Profile.Name.contains('Custom: Support Profile')){
			return true;
		}
		return false;
	}

}