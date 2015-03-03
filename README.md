# Infuser

A cleaner Ruby wrapper for the InfusionSoft API.

This gem in an altered version of [Nathan Levitt's gem](https://github.com/nateleavitt/infusionsoft). The original gem uses a flat structure. I prefer namespaced. For example, I prefer `Infuser::Contacts.all` to `Infuser.all_contacts`, and `Infuser::Contacts.find(1)` to `Infuser.contact_load(1)`. I simply re-organized the gem accordingly. Code credit goes to Nathan.

This gem also supports the Ruby idiom of underscoring hash keys rather than camel-casing them.

## Installation
    gem install infuser

## Setup

Create an initializer file in your Rails app, with:

```ruby
  Infuser.configure do |config|
    config.api_url = 'Infuser-URL'
    config.api_key = 'Infuser-API-KEY'
  end
```

## Usage

```
  # Get a users first and last name using the DataService
  Infuser.data_load('Contact', contact_id, [:FirstName, :LastName])

  # Get a list of custom fields
  Infuser.data_find_by_field('DataFormField', 100, 0, 'FormId', -1, ['Name'])
  # Note, when updating custom fields they are case sensisitve and need to be prefaced with a '_'

  # Update a contact with specific field values
  Infuser.contact_update(contact_id, { :FirstName => 'first_name', :Email => 'test@test.com' })

  # Add a new Contact
  Infuser.contact_add({:FirstName => 'first_name', :LastName => 'last_name', :Email => 'test@test.com'})

  # Create a blank Invoice
  invoice_id = Infuser.invoice_create_blank_order(contact_id, description, Date.today, lead_affiliate_id, sale_affiliate_id)

  # Then add item to invoice
  Infuser.invoice_add_order_item(invoice_id, product_id, product_type, amount, quantity, description_here, notes)

  # Then charge the invoice
  Infuser.invoice_charge_invoice(invoice_id, notes, credit_card_id, merchange_id, bypass_commissions)
```

## Issues
Submit the issue on Github. I handle gems in my spare time, so no promises on when I can look into things.

## Copyright
Copyright (c) 2014 David Lesches

Original code (c) Nathan Levitt

## License
Released under standard MIT license.