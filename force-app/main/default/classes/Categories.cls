public with sharing class Categories {
    // Class to create formatted category objects
    public with sharing class FormattedCategory {
        private Id catId;
        private Map<String, String> fields = new Map<String, String>();
        private List<FormattedCategory> childCategories = new List<FormattedCategory>();
        private String categoryURL;

        FormattedCategory(ConnectApi.productCategoryDetail productCategory, String basePath) {
            this.fields = productCategory.fields;
            this.catId = productCategory.Id;
            this.categoryURL = createCategoryURL(basePath, productCategory.fields, productCategory.Id);
        }

        private String createCategoryURL(String basePath, Map<String, String> categoryFields, String categoryId) {
            String categoryName = categoryFields.get('Name');

            String formattedCategoryURL = '/category/' + categoryName.replaceAll(' ', '-') + '/' + categoryId;
            return formattedCategoryURL;
        }
    }

    // recursively create a nested list of category objects and their children
    private static List<FormattedCategory> formatCategories(Id webStoreId, Id categoryId, String basePath) {
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
        
        List<FormattedCategory> categories = new List<FormattedCategory>();

        // if categories dont have children getProductCategoryChildren() will throw a exception
        try {
            ConnectApi.ProductCategoryDetailCollection cats = ConnectApi.commerceCatalog.getProductCategoryChildren(webStoreId, null, categoryId, fields, False, null, True);
            for (ConnectApi.ProductCategoryDetail cat: cats.ProductCategories) {
                FormattedCategory newCategory = new FormattedCategory(cat, basePath);
                newCategory.childCategories = formatCategories(webStoreId, newCategory.catId, basePath);
                categories.add(newCategory);
            }
        } catch (Exception e) {
            ConnectApi.productCategoryDetail cat = ConnectApi.commerceCatalog.getProductCategory(webStoreId, categoryId, null, fields, False, null, True);
            FormattedCategory newCategory = new FormattedCategory(cat, basePath);
            categories.add(newCategory);
            return categories;
        }

        return categories;
    }

    @AuraEnabled(cacheable=true)
    public static String getCategories(Id communityId, Id categoryId) {
        List<Network> basePathQuery = [SELECT UrlPathPrefix, Name FROM Network WHERE Id = :communityId WITH SECURITY_ENFORCED LIMIT 1];
        String unFormattedBasePath = basePathQuery[0].UrlPathPrefix.replace('vforcesite', '');
        String basePath = unFormattedBasePath.length() > 0 ? '/' + unFormattedBasePath : '';

        List<WebStoreNetwork> webStoreIdList = [SELECT WebStoreId FROM WebStoreNetwork WHERE NetworkId = :communityId];
        Id webStoreId = webStoreIdList[0].webStoreId;
        return JSON.serialize(formatCategories(webStoreId, categoryId, basePath));
    }
}