
// List<WebStoreNetwork> webStoreIdList = [SELECT WebStoreId FROM WebStoreNetwork WHERE NetworkId = '0DB7g0000004m9BGAQ'];
// Id webStoreId = webStoreIdList[0].webStoreId;

// Integer counter = 0;

// List<FormattedCategory> formattedCats = Categories.getCategories('0ZE7g0000008R4bGAE', null, counter);
// List<FormattedCategory> cats = Categories.getCategories('0ZE7g0000008R4bGAE', null, 0);


List<Categories.FormattedCategory> formattedCats = Categories.getCategories('0ZE7g0000008R4bGAE', null, 0);

for (Categories.FormattedCategory i : formattedCats) {
	System.debug(i.fields.get('Name'));
	for (Categories.FormattedCategory level1 : i.childCategories) {
		System.debug(i.fields.get('Name'));
	}


}