public with sharing class Categories {
    public with sharing class FormattedCategory {
        public Id catId;
        public Map<String, String> fields = new Map<String, String>();
        public List<FormattedCategory> childCategories = new List<FormattedCategory>();

        FormattedCategory(ConnectApi.productCategoryDetail productCategory) {
            this.fields = productCategory.fields;
            this.catId = productCategory.Id;

        }
    }

    public static List<FormattedCategory> formatCategories(Id communityId, Id categoryId) {
        List<FormattedCategory> categories = new List<FormattedCategory>();

        List<WebStoreNetwork> webStoreIdList = [SELECT WebStoreId FROM WebStoreNetwork WHERE NetworkId = '0DB7g0000004m9BGAQ'];
        Id webStoreId = webStoreIdList[0].webStoreId;

        List<String> fields = new List<String>{
        'CatalogId', 
        'CurrencyIsoCode', 
        'Description', 
        'IsNavigational', 
        'LastReferencedDate',
        'LastViewedDate',
        'Name',
        'NumberOfProducts',
        'ProductCategoryId',
        'SortOrder'
        };
        
        try {
            ConnectApi.ProductCategoryDetailCollection cats = ConnectApi.commerceCatalog.getProductCategoryChildren(webStoreId, null, categoryId, fields, False, null, True);
            for (ConnectApi.ProductCategoryDetail cat: cats.ProductCategories) {
                FormattedCategory newCategory = new FormattedCategory(cat);
                newCategory.childCategories = formatCategories(webStoreId, newCategory.catId);
                categories.add(newCategory);
            }
    
        } catch (Exception e) {
            ConnectApi.productCategoryDetail test = ConnectApi.commerceCatalog.getProductCategory(webStoreId, categoryId, null, fields, False, null, True);
            FormattedCategory newCategory = new FormattedCategory(test);
            categories.add(newCategory);
            return categories;
        }

        return categories;
    }

    @AuraEnabled(cacheable=true)
    public static String getCategories(Id communityId, Id categoryId) {
        return JSON.serialize(formatCategories(communityId, categoryId));
    }
}
