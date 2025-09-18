# Customized Lokalise Pull Action for Android Resource Resolution

This is a **customized Lokalise Pull GitHub Action** that renames folder paths to comply with **Android's updated resource-resolution strategy**: [Android Multilingual Support](https://developer.android.com/guide/topics/resources/multilingual-support#postN).

## Scenario

1. The customer uploads source keys to Lokalise with a standard path, for example:  
g11n/data/src/main/res/values/en/strings.xml

2. The customer requires that the downloaded file path for Spanish follows Android's new naming convention for language variants, e.g.:  
g11n/data/src/main/res/values-b+es+419/strings.xml
*Note:* The target language folder is not a subdirectory of `values`; instead, the folder name encodes the language and region variant.

3. Updating the language mapping, for example:  

    {"original_language_iso":"es_419","custom_language_iso":"b+es+419"}    only changes the ISO code but does not update the folder structure. This would produce:

    g11n/data/src/main/res/values/b+es+419/strings.xml

### Solutions

There are two ways to address this folder structure requirement:

1. One Pull per Language

    Configure a separate pull for each target language.

    Specify both the bundle structure and the language filter.

    See: .github/workflows/pull.yml

2. Post-Processing Approach

    Implement a post-processing step to map region codes and rename folders according to Android conventions.

    See: .github/workflows/pull_post_process.yml and .scripts/rename.rb

    This approach is more scalable.