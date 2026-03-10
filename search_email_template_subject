/*
Author: Annindya Das
Date: 12/11/2025
Description: Use to search in email template subject that may contain search string in needle variable.
*/

String needle = 'has been assigned to you';
String needleLower = needle.toLowerCase();

List<Id> matchingTemplateIds = new List<Id>();

// NOTE: Subject is not filterable in SOQL for EmailTemplate, so we fetch then filter in Apex.
// If you have many templates, consider limiting or paging (see notes below).
List<EmailTemplate> templates = [
    SELECT Id, Subject
    FROM EmailTemplate
    ORDER BY LastUsedDate DESC NULLS LAST, LastModifiedDate DESC
];

for (EmailTemplate et : templates) {
    if (et.Subject != null && et.Subject.toLowerCase().contains(needleLower)) {
        matchingTemplateIds.add(et.Id);
        System.debug('Match: ' + et.Id + ' | Subject: ' + et.Subject);
    }
}

System.debug('Matching EmailTemplate Ids: ' + matchingTemplateIds);

