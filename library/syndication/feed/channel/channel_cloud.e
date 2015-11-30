indexing
	description: "Class to represent a channel cloud sub-element."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 09:06:57 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 251 $"

class
	CHANNEL_CLOUD

create
	make
	
feature -- Initialization

	make (a_domain: STRING; a_port: INTEGER; a_path: STRING; a_register_procedure: STRING; a_protocol: STRING) is
			-- Create a channel cloud with domain, port, path, register procedure and protocol
		require
			non_empty_domain: a_domain /= Void and then not a_domain.is_empty
			port_number_non_negative: a_port >= 0
			non_empty_path: a_path /= Void and then not a_path.is_empty
			non_empty_register_procedure: a_register_procedure /= Void and then not a_register_procedure.is_empty
			non_empty_protocol: a_protocol /= Void and then not a_protocol.is_empty
		do
			set_domain (a_domain)
			set_port (a_port)
			set_path (a_path)
			set_register_procedure (a_register_procedure)
			set_protocol (a_protocol)
		end
		
feature -- Access

	domain: STRING
			-- Domain of the cloud
			
	port: INTEGER
			-- Port of the cloud
			
	path: STRING
			-- Path of the cloud
			
	register_procedure: STRING
			-- Register procedure of the cloud
			
	protocol: STRING
			-- Protocol of the cloud

feature -- Setter

	set_domain (a_domain: STRING) is
			-- Set domain to`a_domain'
		require
			non_empty_domain: a_domain /= Void and then not a_domain.is_empty
		do
			domain := a_domain
		ensure
			domain_set: domain = a_domain
		end
		
	set_port (a_port: INTEGER) is
			-- Set port to `a_port'
		require
			port_number_non_negative: a_port >= 0
		do
			port := a_port
		ensure
			port_set: port = a_port
		end
		
	set_path (a_path: STRING) is
			-- Set path to `a_path'
		require
			non_empty_path: a_path /= Void and then not a_path.is_empty
		do
			path := a_path
		ensure
			path_set: path = a_path
		end
		
	set_register_procedure (a_register_procedure: STRING) is
			-- Set register_procedure to `a_register_procedure'
		require
			non_empty_register_procedure: a_register_procedure /= Void and then not a_register_procedure.is_empty
		do
			register_procedure := a_register_procedure
		ensure
			register_procedure_set: register_procedure = a_register_procedure
		end
		
	set_protocol (a_protocol: STRING) is
			-- Set protocol to `a_protocol'
		require
			non_empty_protocol: a_protocol /= Void and then not a_protocol.is_empty
		do
			protocol := a_protocol
		ensure
			protocol_set: protocol = a_protocol
		end

feature -- Debug

	to_string: STRING is
			-- Returns a string representation of cloud
			-- This feature is especially useful for debugging
		do
			Result := "* Domain: " + domain + "%N* Port: " + port.out + "%N* Path: " + path + "%N* Register procedure: " + register_procedure + "%N* Protocol: " + protocol + "%N"
		end

invariant
	non_empty_domain: domain /= Void and then not domain.is_empty
	port_number_non_negative: port >= 0
	non_empty_path: path /= Void and then not path.is_empty
	non_empty_register_procedure: register_procedure /= Void and then not register_procedure.is_empty
	non_empty_protocol: protocol /= Void and then not protocol.is_empty

end -- class CHANNEL_CLOUD
