<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  xmlns:members="http://michael-eichelsdoerfer.de/xslt/members"
  extension-element-prefixes="exsl members">

  <xsl:import href="members-forms/members.forms.xsl"/>

  <xsl:template name="members-form-register">
    <xsl:variable name="event" select="'members-new'"/>

    <xsl:call-template name="members:validate">
      <xsl:with-param name="event" select="$event"/>
    </xsl:call-template>

    <form action="{concat(/data/params/current-url, '/')}" method="post">
      <div>
        <!-- Use the ID of your current Members section! -->
        <input type="hidden" name="members-section-id" value="99"/>
      </div>
      <xsl:call-template name="members:input">
        <xsl:with-param name="field" select="'username'"/>
        <xsl:with-param name="event" select="$event"/>
      </xsl:call-template>
      <xsl:call-template name="members:input-password">
        <xsl:with-param name="event" select="$event"/>
        <xsl:with-param name="mode" select="'new'"/>
      </xsl:call-template>
      <xsl:call-template name="members:input-password-confirm">
        <xsl:with-param name="event" select="$event"/>
        <xsl:with-param name="mode" select="'new'"/>
      </xsl:call-template>
      <xsl:call-template name="members:input">
        <xsl:with-param name="field" select="'email'"/>
        <xsl:with-param name="event" select="$event"/>
      </xsl:call-template>
      <xsl:call-template name="members:input-submit">
        <xsl:with-param name="event" select="$event"/>
      </xsl:call-template>
    </form>
  </xsl:template>

</xsl:stylesheet>
