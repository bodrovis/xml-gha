This is a customized Lokalsie Pull Action that renames folder paths to comply with Android's improvements to resource-resolution strategy: https://developer.android.com/guide/topics/resources/multilingual-support#postN

The scenario is:
1. Lokalise customer uploads source keys to Lokalise with folder/file path:g 11n/data/src/main/res/values/en/strings.xml
2. Customer requires the downloaded file path for Spanish to be g11n/data/src/main/res/values-b+es+419/strings.xml. The difference is that the values folder name includes Androids naming converntion for the Lang ISO variant, and the target lagnauge is not a subdirectory of the values folder.
3. Changing language mappings ex: {"original_language_iso":"es_419","custom_language_iso":"b+es+419"} results only in the changing of the ISO code, not the folder structure. EX: g11n/data/src/main/res/values/b+es+419/strings.xml
4. To solve the problem, we can 
