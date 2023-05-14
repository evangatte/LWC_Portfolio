public with sharing class Content {
    @AuraEnabled(cacheable=true)
    public static Map<String, ConnectApi.ManagedContentNodeValue> getContent(
    // public static ConnectApi.ManagedContentVersionCollection getContent(
        String communityId,
        String[] managedContentIds,
        Integer pageParam,
        Integer pageSize,
        String language,
        String managedContentType,
        Boolean showAbsoluteUrl
    ) {
        try {
            ConnectApi.ManagedContentVersionCollection contentCollection = ConnectApi.ManagedContent.getManagedContentByContentKeys(communityId, managedContentIds, pageParam, pageSize, language, managedContentType, showAbsoluteUrl);
            return contentCollection.items[0].contentNodes;
        } catch (ConnectApi.ConnectApiException e) {
            System.debug('Error Message : ' + e);
            Map<String, ConnectApi.ManagedContentNodeValue> mcnvMap = new Map<String, ConnectApi.ManagedContentNodeValue>();
            return mcnvMap;
        }
    }
}