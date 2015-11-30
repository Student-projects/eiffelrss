indexing
	description: "Implementation of HTTP 1.1"
	author: ""
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	FETCH_HTTP_PROTOCOL
	
inherit
	HTTP_PROTOCOL
	
redefine
	initiate_transfer,
	get_headers
	end
	
create
	make

feature
		initiate_transfer is
			-- Initiate transfer.
		local
			str: STRING
		do
			str := Http_get_command.twin
			str.extend (' ')
			if address.is_proxy_used then
				str.append (location)
			else
				str.extend ('/')
				str.append (address.path)
			end
			str.extend (' ')
			str.append ("HTTP/1.1%R%NHost: ")
			str.append (address.host)
			str.append (Http_end_of_command)
			if not error then
				main_socket.put_string (str)
					debug
						Io.error.put_string (str)
					end
				get_headers
				transfer_initiated := True
				is_packet_pending := True
			end
		rescue
			error_code := Transfer_failed
		end
		
	get_headers is
			-- Get HTTP headers
		local
			str: STRING
		do
			headers.wipe_out
			from
			until
				error or else (str /= Void and str.is_equal ("%R"))
			loop
				check_socket (main_socket, Read_only)
				if not error then
					main_socket.read_line
					str := main_socket.last_string.twin
						debug
							Io.error.put_string (str)
							Io.error.put_new_line
						end
					if not str.is_empty then headers.extend (str) end
				end
			end
			check_error
			if not error then 
				check_socket (main_socket, Read_only)
				if not error then main_socket.read_line end
				get_content_length 
			end
		end


end -- class FETCH_HTTP_PROTOCOL
