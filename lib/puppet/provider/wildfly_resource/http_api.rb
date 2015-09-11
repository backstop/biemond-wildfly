require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'puppet_x', 'util', "wildfly_cli.rb"))

Puppet::Type.type(:wildfly_resource).provide(:http_api) do
  desc 'Uses JBoss HTTP API to manipulate a resource'

  def cli
    PuppetX::Util::WildflyCli.instance(@resource[:host], @resource[:port], @resource[:username], @resource[:password])
  end

  def create
    debug "Creating #{@resource[:path]} with state #{@resource[:state].inspect}"
    if @resource[:recursive]
      cli.add_recursive(@resource[:path], @resource[:state])
    else
      cli.add(@resource[:path], @resource[:state])
    end
  end

  def destroy
    debug "Destroying #{@resource[:path]}"
    cli.remove(@resource[:path])
  end

  def exists?
    debug "Exists? #{@resource[:path]}"
    cli.exists?(@resource[:path])
  end

  def state
    debug "Retrieve state: #{@resource[:path]}"
    cli.read(@resource[:path], @resource[:recursive])
  end

  def state=(value)
    debug "Updating state for: #{@resource[:path]} with #{@resource[:state].inspect}"
    if @resource[:recursive]
      cli.update_recursive(@resource[:path], value, @resource[:merge_on_update])
    else
      cli.update(@resource[:path], value, @resource[:merge_on_update])
    end
  end
end
