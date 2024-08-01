;; extends

(macro_invocation
	(scoped_identifier
		path: (identifier) @path (#eq? @path "sqlx")
		name: (identifier) @name (#any-of? @name "query_as" "query"))
		(token_tree
			[(raw_string_literal) (string_literal)] @injection.content)
			; (#offset! @injection.content 0 3 0 -2)
			(#set! injection.language "sql")
)

(call_expression
	(generic_function
		(scoped_identifier
			path: (identifier) @path (#eq? @path "sqlx")
			name: (identifier) @name (#eq? @name "query_as" )
			))
		(arguments
			[(raw_string_literal) (string_literal)] @injection.content)
			; (#offset! @injection.content 0 3 0 -2)
			(#set! injection.language "sql")
)

(call_expression
	(generic_function
		(scoped_identifier
			path: (identifier) @path (#eq? @path "sqlx")
			name: (identifier) @name (#eq? @name "query" )
			))
		(arguments
			[(raw_string_literal) (string_literal)] @injection.content)
			; (#offset! @injection.content 0 3 0 -2)
			(#set! injection.language "sql")
)
