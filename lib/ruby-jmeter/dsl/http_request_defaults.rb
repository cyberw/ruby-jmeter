module RubyJmeter
  class DSL
    def http_request_defaults(params={}, &block)
      node = RubyJmeter::HttpRequestDefaults.new(params)
      attach_node(node, &block)
    end
  end

  class HttpRequestDefaults
    attr_accessor :doc
    include Helper

    def initialize(params={})
      testname = params.kind_of?(Array) ? 'HttpRequestDefaults' : (params[:name] || 'HttpRequestDefaults')
      @doc = Nokogiri::XML(<<-EOS.strip_heredoc)
  <ConfigTestElement enabled="true" guiclass="HttpDefaultsGui" testclass="ConfigTestElement" testname="#{testname}">
    <elementProp elementType="Arguments" enabled="true" guiclass="HTTPArgumentsPanel" name="HTTPsampler.Arguments" testclass="Arguments" testname="#{testname}">
      <collectionProp name="Arguments.arguments"/>
    </elementProp>
    <stringProp name="HTTPSampler.domain"/>
    <stringProp name="HTTPSampler.port"/>
    <stringProp name="HTTPSampler.proxyHost"/>
    <stringProp name="HTTPSampler.proxyPort"/>
    <stringProp name="HTTPSampler.connect_timeout"/>
    <stringProp name="HTTPSampler.response_timeout"/>
    <stringProp name="HTTPSampler.protocol"/>
    <stringProp name="HTTPSampler.contentEncoding"/>
    <stringProp name="HTTPSampler.path">/</stringProp>
    <stringProp name="HTTPSampler.implementation">HttpClient4</stringProp>
    <boolProp name="HTTPSampler.image_parser">true</boolProp>
    <boolProp name="HTTPSampler.concurrentDwn">true</boolProp>
    <stringProp name="HTTPSampler.concurrentPool">4</stringProp>
    <stringProp name="HTTPSampler.embedded_url_re"/>
  </ConfigTestElement>)
      EOS
      update params
      update_at_xpath params if params.is_a?(Hash) && params[:update_at_xpath]
    end
  end

end
