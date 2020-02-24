# Using Google Sheets with Ruby and Sinatra

This is a sample application that uses Sinatra to host a site that saves data in a Google Sheet.

## Running the application

### Get setup with Google Sheets

Follow the steps in [this blog post](https://www.twilio.com/blog/2017/03/google-spreadsheets-ruby.html) to create the credentials for a service account in the Google APIs Console. Download the credentials and copy them to this project with the filename `client_secret.json`.

You will also need to create a blank spreadsheet and give your service account access to edit.

### Download and prepare the app

Clone this repository with the command:

```bash
git clone https://github.com/philnash/ruby-google-sheets-sinatra.git
cd ruby-google-sheets-sinatra
```

Install the dependencies:

```bash
bundle install
```

### Read the blog post!

Follow the instructions to [create a landing page with Sinatra, Google Spreadsheets, and Ruby](https://www.twilio.com/blog/2017/03/create-a-landing-page-with-sinatra-google-spreadsheets-and-ruby.html).

You can also inspect the final code in the [save-data](https://github.com/philnash/ruby-google-sheets-sinatra/tree/save-data) branch.

Want to take it further? Learn how to [validate Ruby objects with Active Model Validations](https://www.twilio.com/blog/2017/06/validate-ruby-objects-with-active-model-validations.html) and see how it applies in the [validations](https://github.com/philnash/ruby-google-sheets-sinatra/tree/validations) branch.
