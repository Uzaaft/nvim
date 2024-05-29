;; extends
((inline) @_inline (#match? @_inline "^\(import\|export\)")) @nospell

; checkboxes
((task_list_marker_unchecked) @markdown_check_undone (#set! conceal "󰄱"))
((task_list_marker_checked) @markdown_check_done (#set! conceal "󰄵"))

; box drawing characters for tables
(pipe_table_header ("|") @punctuation.special @conceal (#set! conceal "│"))
(pipe_table_delimiter_row ("|") @punctuation.special @conceal (#set! conceal "│"))
(pipe_table_delimiter_cell ("-") @punctuation.special @conceal (#set! conceal "─"))
(pipe_table_row ("|") @punctuation.special @conceal (#set! conceal "│"))
