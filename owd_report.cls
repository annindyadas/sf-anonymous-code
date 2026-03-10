/*
Author: Annindya Das
Date: 3/10/2026
Description: Use to generate OWD report as log that can be copied to excel for filtering and other reporting purposes.
Example: QualifiedApiName=Contact, DeveloperName=Contact, InternalSharingModel=Private, ExternalSharingModel=Private
*/

List<String> apiNames = new List<String>(); String lastEntityQueried; List<String> rows = new List<String>();

do { List<EntityDefinition> defs = [ SELECT QualifiedApiName, DeveloperName, ExternalSharingModel, InternalSharingModel FROM EntityDefinition WHERE QualifiedApiName > :lastEntityQueried AND IsCustomizable = TRUE AND IsApexTriggerable = TRUE ORDER BY QualifiedApiName ASC LIMIT 2000 ]; if (defs.isEmpty()) { break; }

for (EntityDefinition def : defs) {
    apiNames.add(def.QualifiedApiName);
    // Build a readable row for this entity's OWD-related data
    rows.add(
        'QualifiedApiName=' + String.valueOf(def.QualifiedApiName) +
        ', DeveloperName=' + String.valueOf(def.DeveloperName) +
        ', InternalSharingModel=' + String.valueOf(def.InternalSharingModel) +
        ', ExternalSharingModel=' + String.valueOf(def.ExternalSharingModel)
    );
}

lastEntityQueried = defs[defs.size() - 1].QualifiedApiName;

if (defs.size() < 2000) {
    break;
}


} while (true);

// Single consolidated debug output 
System.debug('Total entities: ' + apiNames.size()); System.debug('OWD Data:\n' + String.join(rows, '\n'));
