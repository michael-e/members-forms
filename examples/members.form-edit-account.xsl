<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	xmlns:members="http://michael-eichelsdoerfer.de/xslt/members"
	extension-element-prefixes="exsl members">

<xsl:import href="members-forms/members.forms.xsl"/>

<xsl:template name="members-form-edit-account">
	
	<xsl:variable name="event" select="'members-edit'"/>

	<xsl:call-template name="members:validate">
		<xsl:with-param name="event" select="$event"/>
	</xsl:call-template>

	<form action="" method="post">
		<input type="hidden" name="id" value="{//events/member-login-info/@id}"/>
		<xsl:call-template name="members:input">
			<xsl:with-param name="field" select="'username'"/>
			<xsl:with-param name="event" select="$event"/>
			<xsl:with-param name="value" select="/data/*[name()=$members:config/data/datasources/member/@handle]/entry/*[name()=$members:config/data/fields/*[@type='username']/@handle]"/>
		</xsl:call-template>
		<xsl:call-template name="members:input-password">
			<xsl:with-param name="event" select="$event"/>
			<xsl:with-param name="mode" select="'edit'"/>
		</xsl:call-template>
		<xsl:call-template name="members:input-password-confirm">
			<xsl:with-param name="event" select="$event"/>
			<xsl:with-param name="mode" select="'edit'"/>
		</xsl:call-template>
		<xsl:call-template name="members:input">
			<xsl:with-param name="field" select="'email'"/>
			<xsl:with-param name="event" select="$event"/>
			<xsl:with-param name="value" select="//*[name()=$members:config/data/datasources/member/@handle]/entry/*[name()=$members:config/data/fields/*[@type='email']/@handle]"/>
		</xsl:call-template>
		<xsl:call-template name="members:input-submit">
			<xsl:with-param name="event" select="$event"/>
		</xsl:call-template>
	</form>

</xsl:template>

</xsl:stylesheet>
