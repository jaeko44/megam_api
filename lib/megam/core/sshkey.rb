module Megam
    class SshKey < Megam::RestAdapter
        def initialize(o)
            @id = nil
            @name = nil
            @org_id = nil
            @privatekey=nil
            @publickey=nil
            @created_at = nil
            @some_msg = {}
            super(o)
        end

        def sshkey
            self
        end

        def id(arg=nil)
            if arg != nil
                @id = arg
            else
                @id
            end
        end

        def name(arg=nil)
            if arg != nil
                @name = arg
            else
                @name
            end
        end

        def org_id(arg=nil)
            if arg != nil
                @org_id= arg
            else
                @org_id
            end
        end

        def privatekey(arg=nil)
            if arg != nil
                @privatekey = arg
            else
                @privatekey
            end
        end

        def publickey(arg=nil)
            if arg != nil
                @publickey = arg
            else
                @publickey
            end
        end


        def created_at(arg=nil)
            if arg != nil
                @created_at = arg
            else
                @created_at
            end
        end

        def some_msg(arg=nil)
            if arg != nil
                @some_msg = arg
            else
                @some_msg
            end
        end

        def error?
            crocked  = true if (some_msg.has_key?(:msg_type) && some_msg[:msg_type] == "error")
        end

        # Transform the ruby obj ->  to a Hash
        def to_hash
            index_hash = Hash.new
            index_hash["json_claz"] = self.class.name
            index_hash["id"] = id
            index_hash["name"] = name
            index_hash["org_id"] = org_id
            index_hash["privatekey"] = privatekey
            index_hash["publickey"] = publickey
            index_hash["created_at"] = created_at
            index_hash
        end

        # Serialize this object as a hash: called from JsonCompat.
        # Verify if this called from JsonCompat during testing.
        def to_json(*a)
            for_json.to_json(*a)
        end

        def for_json
            result = {
                "id" => id,
                "name" => name,
                "org_id" => org_id,
                "privatekey" => privatekey,
                "publickey" => publickey,
                "created_at" => created_at
            }
            result
        end

        #
        def self.json_create(o)
            sshKey = new({})
            sshKey.id(o["id"]) if o.has_key?("id")
            sshKey.name(o["name"]) if o.has_key?("name")
            sshKey.privatekey(o["privatekey"]) if o.has_key?("privatekey")
            sshKey.publickey(o["publickey"]) if o.has_key?("publickey")
            sshKey.created_at(o["created_at"]) if o.has_key?("created_at")
            #success or error
            sshKey.some_msg[:code] = o["code"] if o.has_key?("code")
            sshKey.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
            sshKey.some_msg[:msg]= o["msg"] if o.has_key?("msg")
            sshKey.some_msg[:links] = o["links"] if o.has_key?("links")
            sshKey
        end

        def self.from_hash(o)
            sshKey = self.new(o)
            sshKey.from_hash(o)
            sshKey
        end

        def from_hash(o)
            @id        = o[:id] if o.has_key?(:id)
            @name = o[:name] if o.has_key?(:name)
            @org_id = o[:org_id] if o.has_key?(:org_id)
            @privatekey = o[:privatekey] if o.has_key?(:privatekey)
            @publickey = o[:publickey] if o.has_key?(:publickey)
            @created_at   = o[:created_at] if o.has_key?(:created_at)
            self
        end

        def self.create(params)
            acct = from_hash(params)
            acct.create
        end

        # Create the predef via the REST API
        def create
            megam_rest.post_sshkey(to_hash)
        end

        # Load all sshkeys -
        # returns a sshkeysCollection
        # don't return self. check if the Megam::SshKeyCollection is returned.
        def self.list(params)
            sshKey = self.new(params)
            sshKey.megam_rest.get_sshkeys
        end

        # Show a particular sshKey by name,
        # Megam::SshKey
        def self.show(params)
            pre = self.new(params)
            pre.megam_rest.get_sshkey(params["name"])
        end

        def to_s
            Megam::Stuff.styled_hash(to_hash)
            #"---> Megam::Account:[error=#{error?}]\n"+
        end

    end
end
