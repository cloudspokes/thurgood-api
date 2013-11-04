class Job2

  def self.find_by_job_id(id)

    options = { 
      :headers => api_request_headers   
    }

    job2 = Hashie::Mash.new HTTParty.get("#{ENV['THURGOOD_V2_URL']}/#{id}", options)
    if job2.success
      data = job2.data.first
      job = Job.new
      job.code_url = data.codeUrl 
      job.created_at = data.createdAt
      job.email = data.email
      job.endtime = data.endTime
      job.job_id = data._id
      job.language = data.language
      if data.options.empty?
        job.options = {} 
      else
        job.options = data.options.first.to_json
      end
      job.papertrail_system = data.loggerId
      job.platform = data.platform
      job.starttime = data.startTime
      job.status = data.status
      job.updated_at = data.updatedAt
      job.user_id = data.userId
      return job
    end
  end

    def self.api_request_headers
      {
        'Authorization' => 'Token token="'+ENV['THURGOOD_V2_API_KEY']+'"',
        'Content-Type' => 'application/json'
      }
    end       

end