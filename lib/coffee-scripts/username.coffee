Ext.namespace "gxp.plugins"
gxp.plugins.Username = Ext.extend(gxp.plugins.Tool,
  ptype: "gispro_josso_username"
  userText: "User"

  addActions: ->
    OpenLayers.Request.GET(
      url: @target.jossoInfoUrl
      callback: (request)->
        if request.status == 200
          match = request.responseText.match(/<li><h4>Username:<\/h4>(.+)<\/li>/)
          if match?
            @target.josso_username = match[1]
            @target.fireEvent 'usernamechanged', @target.josso_username
      scope: @
      proxy: @target.proxy
    )

    @label = new Ext.form.Label(
      text: @textFormat(@target.josso_username)
      style:
        marginLeft: '10px'
        marginRight: '10px'
        fontWeight: 'bold'
    )

    @target.on 'usernamechanged', (username)->
      @label.setText(@textFormat(username))
    ,@

    gxp.plugins.Username.superclass.addActions.apply this, [ @label ]

  textFormat: (t)->
    "#{@userText}: #{t}"

)
Ext.preg gxp.plugins.Username::ptype, gxp.plugins.Username
