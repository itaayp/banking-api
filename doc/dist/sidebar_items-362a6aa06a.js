sidebarNodes={"extras":[{"group":"","headers":[{"anchor":"modules","id":"Modules"}],"id":"api-reference","title":"API Reference"}],"modules":[{"group":"","id":"BankingApi","sections":[],"title":"BankingApi"},{"group":"","id":"BankingApi.Accounts","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"create_user/1","id":"create_user/1"},{"anchor":"get!/1","id":"get!/1"},{"anchor":"get_user!/1","id":"get_user!/1"}]}],"sections":[],"title":"BankingApi.Accounts"},{"group":"","id":"BankingApi.Accounts.Account","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"__struct__/0","id":"__struct__/0"},{"anchor":"changeset/2","id":"changeset/2"}]}],"sections":[],"title":"BankingApi.Accounts.Account"},{"group":"","id":"BankingApi.Accounts.Auth.ErrorHandler","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"auth_error/3","id":"auth_error/3"}]}],"sections":[],"title":"BankingApi.Accounts.Auth.ErrorHandler"},{"group":"","id":"BankingApi.Accounts.Auth.Guardian","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"after_encode_and_sign/4","id":"after_encode_and_sign/4"},{"anchor":"after_sign_in/5","id":"after_sign_in/5"},{"anchor":"authenticate/2","id":"authenticate/2"},{"anchor":"before_sign_out/3","id":"before_sign_out/3"},{"anchor":"build_claims/3","id":"build_claims/3"},{"anchor":"config/0","id":"config/0"},{"anchor":"config/2","id":"config/2"},{"anchor":"decode_and_verify/3","id":"decode_and_verify/3"},{"anchor":"default_token_type/0","id":"default_token_type/0"},{"anchor":"encode_and_sign/3","id":"encode_and_sign/3"},{"anchor":"exchange/4","id":"exchange/4"},{"anchor":"on_exchange/3","id":"on_exchange/3"},{"anchor":"on_refresh/3","id":"on_refresh/3"},{"anchor":"on_revoke/3","id":"on_revoke/3"},{"anchor":"on_verify/3","id":"on_verify/3"},{"anchor":"peek/1","id":"peek/1"},{"anchor":"refresh/2","id":"refresh/2"},{"anchor":"resource_from_claims/1","id":"resource_from_claims/1"},{"anchor":"resource_from_token/3","id":"resource_from_token/3"},{"anchor":"revoke/2","id":"revoke/2"},{"anchor":"subject_for_token/2","id":"subject_for_token/2"},{"anchor":"verify_claims/2","id":"verify_claims/2"}]}],"sections":[],"title":"BankingApi.Accounts.Auth.Guardian"},{"group":"","id":"BankingApi.Accounts.Auth.Guardian.Plug","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"authenticated?/2","id":"authenticated?/2"},{"anchor":"clear_remember_me/2","id":"clear_remember_me/2"},{"anchor":"current_claims/2","id":"current_claims/2"},{"anchor":"current_resource/2","id":"current_resource/2"},{"anchor":"current_token/2","id":"current_token/2"},{"anchor":"implementation/0","id":"implementation/0"},{"anchor":"put_current_claims/3","id":"put_current_claims/3"},{"anchor":"put_current_resource/3","id":"put_current_resource/3"},{"anchor":"put_current_token/3","id":"put_current_token/3"},{"anchor":"put_session_token/3","id":"put_session_token/3"},{"anchor":"remember_me/4","id":"remember_me/4"},{"anchor":"remember_me_from_token/4","id":"remember_me_from_token/4"},{"anchor":"sign_in/4","id":"sign_in/4"},{"anchor":"sign_out/2","id":"sign_out/2"}]}],"sections":[],"title":"BankingApi.Accounts.Auth.Guardian.Plug"},{"group":"","id":"BankingApi.Accounts.Auth.Pipeline","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"call/2","id":"call/2"},{"anchor":"init/1","id":"init/1"}]}],"sections":[],"title":"BankingApi.Accounts.Auth.Pipeline"},{"group":"","id":"BankingApi.Accounts.Auth.Session","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"authenticate/2","id":"authenticate/2"}]}],"sections":[],"title":"BankingApi.Accounts.Auth.Session"},{"group":"","id":"BankingApi.Accounts.User","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"__struct__/0","id":"__struct__/0"},{"anchor":"changeset/2","id":"changeset/2"}]}],"sections":[],"title":"BankingApi.Accounts.User"},{"group":"","id":"BankingApi.Operations","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"is_transfering_to_same_account?/2","id":"is_transfering_to_same_account?/2"},{"anchor":"perform_operation/3","id":"perform_operation/3"},{"anchor":"transfer/3","id":"transfer/3"},{"anchor":"transfer_operation/3","id":"transfer_operation/3"},{"anchor":"update_account/2","id":"update_account/2"},{"anchor":"withdraw/2","id":"withdraw/2"}]}],"sections":[],"title":"BankingApi.Operations"},{"group":"","id":"BankingApi.Repo","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"aggregate/3","id":"aggregate/3"},{"anchor":"aggregate/4","id":"aggregate/4"},{"anchor":"all/2","id":"all/2"},{"anchor":"checkout/2","id":"checkout/2"},{"anchor":"child_spec/1","id":"child_spec/1"},{"anchor":"config/0","id":"config/0"},{"anchor":"default_options/1","id":"default_options/1"},{"anchor":"delete/2","id":"delete/2"},{"anchor":"delete!/2","id":"delete!/2"},{"anchor":"delete_all/2","id":"delete_all/2"},{"anchor":"exists?/2","id":"exists?/2"},{"anchor":"get/3","id":"get/3"},{"anchor":"get!/3","id":"get!/3"},{"anchor":"get_by/3","id":"get_by/3"},{"anchor":"get_by!/3","id":"get_by!/3"},{"anchor":"get_dynamic_repo/0","id":"get_dynamic_repo/0"},{"anchor":"in_transaction?/0","id":"in_transaction?/0"},{"anchor":"insert/2","id":"insert/2"},{"anchor":"insert!/2","id":"insert!/2"},{"anchor":"insert_all/3","id":"insert_all/3"},{"anchor":"insert_or_update/2","id":"insert_or_update/2"},{"anchor":"insert_or_update!/2","id":"insert_or_update!/2"},{"anchor":"load/2","id":"load/2"},{"anchor":"one/2","id":"one/2"},{"anchor":"one!/2","id":"one!/2"},{"anchor":"preload/3","id":"preload/3"},{"anchor":"prepare_query/3","id":"prepare_query/3"},{"anchor":"put_dynamic_repo/1","id":"put_dynamic_repo/1"},{"anchor":"query/3","id":"query/3"},{"anchor":"query!/3","id":"query!/3"},{"anchor":"rollback/1","id":"rollback/1"},{"anchor":"start_link/1","id":"start_link/1"},{"anchor":"stop/1","id":"stop/1"},{"anchor":"stream/2","id":"stream/2"},{"anchor":"to_sql/2","id":"to_sql/2"},{"anchor":"transaction/2","id":"transaction/2"},{"anchor":"update/2","id":"update/2"},{"anchor":"update!/2","id":"update!/2"},{"anchor":"update_all/3","id":"update_all/3"}]}],"sections":[],"title":"BankingApi.Repo"},{"group":"","id":"BankingApi.Transactions","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"all/0","id":"all/0"},{"anchor":"change_transaction/2","id":"change_transaction/2"},{"anchor":"create_transaction/1","id":"create_transaction/1"},{"anchor":"day/1","id":"day/1"},{"anchor":"delete_transaction/1","id":"delete_transaction/1"},{"anchor":"get_transaction!/1","id":"get_transaction!/1"},{"anchor":"insert_transaction/1","id":"insert_transaction/1"},{"anchor":"month/2","id":"month/2"},{"anchor":"update_transaction/2","id":"update_transaction/2"},{"anchor":"validate_date/2","id":"validate_date/2"},{"anchor":"year/1","id":"year/1"}]}],"sections":[],"title":"BankingApi.Transactions"},{"group":"","id":"BankingApi.Transactions.Helper","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"create_report/1","id":"create_report/1"},{"anchor":"do_query/2","id":"do_query/2"},{"anchor":"list_transactions/0","id":"list_transactions/0"},{"anchor":"query_by_day/1","id":"query_by_day/1"},{"anchor":"query_by_month/2","id":"query_by_month/2"},{"anchor":"query_by_year/1","id":"query_by_year/1"},{"anchor":"sum_amount/1","id":"sum_amount/1"},{"anchor":"validate_date/2","id":"validate_date/2"}]}],"sections":[],"title":"BankingApi.Transactions.Helper"},{"group":"","id":"BankingApi.Transactions.Transaction","sections":[],"title":"BankingApi.Transactions.Transaction"},{"group":"","id":"BankingApiWeb","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"__using__/1","id":"__using__/1"},{"anchor":"channel/0","id":"channel/0"},{"anchor":"controller/0","id":"controller/0"},{"anchor":"router/0","id":"router/0"},{"anchor":"view/0","id":"view/0"}]}],"sections":[],"title":"BankingApiWeb"},{"group":"","id":"BankingApiWeb.ChangesetView","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"__resource__/0","id":"__resource__/0"},{"anchor":"render/2","id":"render/2"},{"anchor":"template_not_found/2","id":"template_not_found/2"},{"anchor":"translate_errors/1","id":"translate_errors/1"}]}],"sections":[],"title":"BankingApiWeb.ChangesetView"},{"group":"","id":"BankingApiWeb.Endpoint","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"broadcast/3","id":"broadcast/3"},{"anchor":"broadcast!/3","id":"broadcast!/3"},{"anchor":"broadcast_from/4","id":"broadcast_from/4"},{"anchor":"broadcast_from!/4","id":"broadcast_from!/4"},{"anchor":"call/2","id":"call/2"},{"anchor":"child_spec/1","id":"child_spec/1"},{"anchor":"config/2","id":"config/2"},{"anchor":"config_change/2","id":"config_change/2"},{"anchor":"host/0","id":"host/0"},{"anchor":"init/1","id":"init/1"},{"anchor":"local_broadcast/3","id":"local_broadcast/3"},{"anchor":"local_broadcast_from/4","id":"local_broadcast_from/4"},{"anchor":"path/1","id":"path/1"},{"anchor":"script_name/0","id":"script_name/0"},{"anchor":"start_link/1","id":"start_link/1"},{"anchor":"static_integrity/1","id":"static_integrity/1"},{"anchor":"static_lookup/1","id":"static_lookup/1"},{"anchor":"static_path/1","id":"static_path/1"},{"anchor":"static_url/0","id":"static_url/0"},{"anchor":"struct_url/0","id":"struct_url/0"},{"anchor":"subscribe/2","id":"subscribe/2"},{"anchor":"unsubscribe/1","id":"unsubscribe/1"},{"anchor":"url/0","id":"url/0"}]}],"sections":[],"title":"BankingApiWeb.Endpoint"},{"group":"","id":"BankingApiWeb.ErrorHelpers","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"error_tag/2","id":"error_tag/2"},{"anchor":"translate_error/1","id":"translate_error/1"}]}],"sections":[],"title":"BankingApiWeb.ErrorHelpers"},{"group":"","id":"BankingApiWeb.ErrorView","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"__resource__/0","id":"__resource__/0"},{"anchor":"render/2","id":"render/2"},{"anchor":"template_not_found/2","id":"template_not_found/2"}]}],"sections":[],"title":"BankingApiWeb.ErrorView"},{"group":"","id":"BankingApiWeb.FallbackController","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"call/2","id":"call/2"}]}],"sections":[],"title":"BankingApiWeb.FallbackController"},{"group":"","id":"BankingApiWeb.Gettext","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"dgettext/3","id":"dgettext/3"},{"anchor":"dgettext_noop/2","id":"dgettext_noop/2"},{"anchor":"dngettext/5","id":"dngettext/5"},{"anchor":"dngettext_noop/3","id":"dngettext_noop/3"},{"anchor":"dpgettext/4","id":"dpgettext/4"},{"anchor":"dpgettext_noop/3","id":"dpgettext_noop/3"},{"anchor":"dpngettext/6","id":"dpngettext/6"},{"anchor":"dpngettext_noop/4","id":"dpngettext_noop/4"},{"anchor":"gettext/2","id":"gettext/2"},{"anchor":"gettext_comment/1","id":"gettext_comment/1"},{"anchor":"gettext_noop/1","id":"gettext_noop/1"},{"anchor":"handle_missing_bindings/2","id":"handle_missing_bindings/2"},{"anchor":"handle_missing_plural_translation/6","id":"handle_missing_plural_translation/6"},{"anchor":"handle_missing_translation/4","id":"handle_missing_translation/4"},{"anchor":"lgettext/5","id":"lgettext/5"},{"anchor":"lngettext/7","id":"lngettext/7"},{"anchor":"ngettext/4","id":"ngettext/4"},{"anchor":"ngettext_noop/2","id":"ngettext_noop/2"},{"anchor":"pgettext/3","id":"pgettext/3"},{"anchor":"pgettext_noop/2","id":"pgettext_noop/2"},{"anchor":"pngettext/5","id":"pngettext/5"},{"anchor":"pngettext_noop/3","id":"pngettext_noop/3"}]}],"sections":[],"title":"BankingApiWeb.Gettext"},{"group":"","id":"BankingApiWeb.LayoutView","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"__resource__/0","id":"__resource__/0"},{"anchor":"render/2","id":"render/2"},{"anchor":"template_not_found/2","id":"template_not_found/2"}]}],"sections":[],"title":"BankingApiWeb.LayoutView"},{"group":"","id":"BankingApiWeb.OperationController","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"transfer/2","id":"transfer/2"},{"anchor":"withdraw/2","id":"withdraw/2"}]}],"sections":[],"title":"BankingApiWeb.OperationController"},{"group":"","id":"BankingApiWeb.OperationView","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"__resource__/0","id":"__resource__/0"},{"anchor":"render/2","id":"render/2"},{"anchor":"template_not_found/2","id":"template_not_found/2"}]}],"sections":[],"title":"BankingApiWeb.OperationView"},{"group":"","id":"BankingApiWeb.Router","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"api/2","id":"api/2"},{"anchor":"auth/2","id":"auth/2"},{"anchor":"browser/2","id":"browser/2"},{"anchor":"call/2","id":"call/2"},{"anchor":"init/1","id":"init/1"}]}],"sections":[],"title":"BankingApiWeb.Router"},{"group":"","id":"BankingApiWeb.Router.Helpers","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"live_dashboard_path/2","id":"live_dashboard_path/2"},{"anchor":"live_dashboard_path/3","id":"live_dashboard_path/3"},{"anchor":"live_dashboard_path/4","id":"live_dashboard_path/4"},{"anchor":"live_dashboard_path/5","id":"live_dashboard_path/5"},{"anchor":"live_dashboard_url/2","id":"live_dashboard_url/2"},{"anchor":"live_dashboard_url/3","id":"live_dashboard_url/3"},{"anchor":"live_dashboard_url/4","id":"live_dashboard_url/4"},{"anchor":"live_dashboard_url/5","id":"live_dashboard_url/5"},{"anchor":"operation_path/2","id":"operation_path/2"},{"anchor":"operation_path/3","id":"operation_path/3"},{"anchor":"operation_url/2","id":"operation_url/2"},{"anchor":"operation_url/3","id":"operation_url/3"},{"anchor":"path/2","id":"path/2"},{"anchor":"static_integrity/2","id":"static_integrity/2"},{"anchor":"static_path/2","id":"static_path/2"},{"anchor":"static_url/2","id":"static_url/2"},{"anchor":"transaction_path/2","id":"transaction_path/2"},{"anchor":"transaction_path/3","id":"transaction_path/3"},{"anchor":"transaction_path/4","id":"transaction_path/4"},{"anchor":"transaction_path/5","id":"transaction_path/5"},{"anchor":"transaction_url/2","id":"transaction_url/2"},{"anchor":"transaction_url/3","id":"transaction_url/3"},{"anchor":"transaction_url/4","id":"transaction_url/4"},{"anchor":"transaction_url/5","id":"transaction_url/5"},{"anchor":"url/1","id":"url/1"},{"anchor":"user_path/2","id":"user_path/2"},{"anchor":"user_path/3","id":"user_path/3"},{"anchor":"user_url/2","id":"user_url/2"},{"anchor":"user_url/3","id":"user_url/3"}]}],"sections":[],"title":"BankingApiWeb.Router.Helpers"},{"group":"","id":"BankingApiWeb.Telemetry","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"child_spec/1","id":"child_spec/1"},{"anchor":"metrics/0","id":"metrics/0"},{"anchor":"start_link/1","id":"start_link/1"}]}],"sections":[],"title":"BankingApiWeb.Telemetry"},{"group":"","id":"BankingApiWeb.TransactionController","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"generate_anual_report/2","id":"generate_anual_report/2"},{"anchor":"generate_daily_report/2","id":"generate_daily_report/2"},{"anchor":"generate_entire_life_report/2","id":"generate_entire_life_report/2"},{"anchor":"generate_monthly_report/2","id":"generate_monthly_report/2"}]}],"sections":[],"title":"BankingApiWeb.TransactionController"},{"group":"","id":"BankingApiWeb.TransactionView","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"__resource__/0","id":"__resource__/0"},{"anchor":"render/2","id":"render/2"},{"anchor":"template_not_found/2","id":"template_not_found/2"}]}],"sections":[],"title":"BankingApiWeb.TransactionView"},{"group":"","id":"BankingApiWeb.UserController","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"show/2","id":"show/2"},{"anchor":"signin/2","id":"signin/2"},{"anchor":"signup/2","id":"signup/2"}]}],"sections":[],"title":"BankingApiWeb.UserController"},{"group":"","id":"BankingApiWeb.UserSocket","sections":[],"title":"BankingApiWeb.UserSocket"},{"group":"","id":"BankingApiWeb.UserView","nodeGroups":[{"key":"functions","name":"Functions","nodes":[{"anchor":"__resource__/0","id":"__resource__/0"},{"anchor":"render/2","id":"render/2"},{"anchor":"template_not_found/2","id":"template_not_found/2"}]}],"sections":[],"title":"BankingApiWeb.UserView"}],"tasks":[]}