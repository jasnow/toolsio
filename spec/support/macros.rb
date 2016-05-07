def drop_schemas
  connection = ActiveRecord::Base.connection.raw_connection
  schemas = connection.query(%Q{
    SELECT 'drop schema ' || nspname || ' cascade;'
    from pg_namespace
    where nspname != 'public'
    AND nspname NOT LIKE 'pg_%'
    AND nspname != 'information_schema';
  })
  schemas.each do |query|
    connection.query(query.values.first)
  end
end

# added here cos we'r using this macro in multiple spec files,
# eventhough it isn't related with the above macro we can still keep it here
def sign_user_in(user, opts={})
  if opts[:subdomain]
    visit new_user_session_url(subdomain: opts[:subdomain])
  else
    visit new_user_session_path
  end

  fill_in 'Email', with: user.email
  fill_in 'Password', with: (opts[:password] || user.password)
  click_button I18n.t('button.sign_in')
end

def set_subdomain(subdomain)
  Capybara.app_host = "http://#{subdomain}.example.com"
end

def select_date_and_time(date, options = {})
  field = options[:from]
  select date.strftime('%Y'), from: "#{field}_1i" #year
  select date.strftime('%B'), from: "#{field}_2i" #month
  select sprintf '%1d', date.strftime('%d'), from: "#{field}_3i" #day 
  select date.strftime('%H'), from: "#{field}_4i" #hour
  select date.strftime('%M'), from: "#{field}_5i" #minute
end

def select_date(date, options = {})
  field = options[:from]
  select date.strftime('%Y'), from: "#{field}_1i" #year
  select date.strftime('%B'), from: "#{field}_2i" #month
  select sprintf '%1d', date.strftime('%d'), :from => "#{field}_3i" #day 
end