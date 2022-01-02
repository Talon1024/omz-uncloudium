#!/usr/bin/env zsh
# Utilities for Uncloudium

uncloudium=${(Az)UNCLOUDIUM:=chromium}

download_crx(){
    # Translate a Chrome Web Store URL into a download URL, and download the extension
    # Example Chrome Web Store URL for Privacy Badger extension: https://chrome.google.com/webstore/detail/privacy-badger/pkehgijcmpdhfbdbbnkijodmdjhbjlgp
    # crx_id="pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # ID for Privacy Badger extension
    # Get extension ID
    # uncloudium=(flatpak run com.github.Eloston.UngoogledChromium)
    webstore_url=${1:?Give me the Chrome Web Store URL for the extension! For example, this is the Chrome Web Store URL for Privacy Badger: https://chrome.google.com/webstore/detail/privacy-badger/pkehgijcmpdhfbdbbnkijodmdjhbjlgp}
    crx_id=${webstore_url:${webstore_url[(I)/]}}
    # version="84.0.4147.135" # This was the Chromium version I was using at the time of writing. It may not be the same for you!
    # Get Chromium version number
    : ${version::=${${$($uncloudium --version | grep -o '[[:digit:]][^[:space:]]\+')}[1]}}
    # print -f "version %s\n" $version
    crx_url="https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${version}&x=id%3D${crx_id}%26installsource%3Dondemand%26uc"
    curl -L $crx_url -o $crx_id.crx
}
