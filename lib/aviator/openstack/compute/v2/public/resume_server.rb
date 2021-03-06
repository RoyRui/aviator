module Aviator

  define_request :resume_server, inherit: [:openstack, :common, :v2, :public, :base] do

    meta :service, :compute

    link 'documentation',
         'http://docs.openstack.org/api/openstack-compute/2/content/POST_resume_v2__tenant_id__servers__server_id__action_ext-os-admin-actions.html'

    param :id,   required: true


    def body
      { resume: nil }
    end


    def headers
      super
    end


    def http_method
      :post
    end


    def url
      "#{ base_url }/servers/#{ params[:id] }/action"
    end

  end

end
