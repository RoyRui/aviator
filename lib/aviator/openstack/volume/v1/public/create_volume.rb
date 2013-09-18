module Aviator

  define_request :create_volume do
    meta :provider,         :openstack
    meta :service,          :volume
    meta :api_version,      :v1
    meta :endpoint_type,    :public

    link 'documentation', 'http://docs.openstack.org/api/openstack-block-storage/2.0/content/Create_Volume.html'

    param :name,                  required: true
    param :description,           required: true
    param :size,                  required: true
    param :volume_type,           required: false
    param :availability_zone,     required: false
    param :metadata,              required: false

    def body
      p = {
        volume: {
         name:          params[:name],
         description:   params[:description],
         size:          params[:size]
        }
      }

      [:availability_zone, :metadata].each do |key|
          p[:volume][key] = params[key] if params[key]
      end

      p
    end

    def headers
      {}.tap do |h|
        h['X-Auth-Token'] = session_data[:access][:token][:id] unless self.anonymous?
      end
    end

    def http_method
      :post
    end

    def url
      service_spec = session_data[:access][:serviceCatalog].find{|s| s[:type] == service.to_s }
      "#{ service_spec[:endpoints][0][:publicURL] }/volumes"
    end
  end

end
