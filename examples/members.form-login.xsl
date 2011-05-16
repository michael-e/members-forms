<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	xmlns:members="http://michael-eichelsdoerfer.de/xslt/members"
	extension-element-prefixes="exsl members">

<xsl:import href="members-forms/members.forms.xsl"/>

<xsl:template name="members-form-login">

	<xsl:variable name="event" select="'member-login-info'"/>

	<xsl:call-template name="members:validate">
		<xsl:with-param name="event" select="$event"/>
	</xsl:call-template>

	<form action="" method="post">
		<xsl:call-template name="members:input-identity">
			<xsl:with-param name="event" select="$event"/>
		</xsl:call-template>
		<xsl:call-template name="members:input-password">
			<xsl:with-param name="event" select="$event"/>
			<xsl:with-param name="mode" select="'login'"/>
		</xsl:call-template>
		<xsl:call-template name="members:input-submit">
			<xsl:with-param name="event" select="$event"/>
			<xsl:with-param name="name" select="'member-action[login]'"/>
		</xsl:call-template>
	</form>

</xsl:template>

</xsl:stylesheet>
