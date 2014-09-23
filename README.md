# Aqbanking

This gem very thinly wraps the aqbanking-cli utility, allowing you to download transactions non-interactively. That utility should be installed and configured before using this gem.

## Installation

Add this line to your application's Gemfile:

    gem 'aqbanking', git: 'https://github.com/VinceG3/aqbanking'

And then execute:

    $ bundle

## Usage

As this is a wrapper around the aqbanking-cli utility, it should be installed. You can install it on OSX with Homebrew

    brew install aqbanking

You don't want to actually configure aqbanking using the cli. It's a finicky pain in the neck. Instead download and install GnuCash and configure it that way. `http://gnucash.org`

Inside GnuCash, go to `Tools -> Online Banking Setup...` The dialog will ask you to start the AQBanking wizard. Load up the wizard and mess around until it will download your transactions. This will probably entail some Googling to figure out the settings for your bank. 

When I put in the details of my bank, it told me the OFX service moved to another location. If this happens to you, put the new URL it gives you into the `Server URL` field and hit `OK`. Then click `Edit User` again and then try to `Retrieve Account List`. If you don't close the window after you edit the URL field, then it will try to retrieve using the old URL. This bit me a few times until I figured it out.

Once you can get your account list, you're done. Close GnuCash and uninstall it if you like. The settings are stored in your home directory under `.aqbanking/` It's those settings the aqbanking-cli tool will use.

You may also be able to get to the wizard without GnuCash, I have not tried this.

This gem will invoke the cli utility to download your transactions, you pass your banking password in as a string. Personally, I use the `lastpass` gem to retrieve the password. The gem bundles an `expect` script to do the dirty work. The data is returned as a bunch of `Transaction` structs 

## Contributing

1. Fork it ( https://github.com/[my-github-username]/aqbanking/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
