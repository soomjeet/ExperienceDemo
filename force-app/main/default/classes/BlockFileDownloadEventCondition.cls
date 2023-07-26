global class BlockFileDownloadEventCondition implements TxnSecurity.EventCondition {

	public boolean evaluate(SObject event) {
        system.debug('event  >> '+event);
		return false;
	}

}