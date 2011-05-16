<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	xmlns:members="http://michael-eichelsdoerfer.de/xslt/members"
	extension-element-prefixes="exsl members">

<xsl:import href="members-forms/members.forms.xsl"/>

<xsl:param name="url-id"/>
<xsl:param name="url-code"/>

<xsl:template name="members-form-reset-password">

	<xsl:variable name="event" select="'members-reset-password'"/>

	<xsl:call-template name="members:validate">
		<xsl:with-param name="event" select="$event"/>
	</xsl:call-template>

	<form action="" method="post">
		<xsl:call-template name="members:input-identity">
			<xsl:with-param name="event" select="$event"/>
			<xsl:with-param name="value" select="$url-id"/>
		</xsl:call-template>
		<xsl:call-template name="members:input-password">
			<xsl:with-param name="event" select="$event"/>
			<xsl:with-param name="mode" select="'edit'"/>
		</xsl:call-template>
		<xsl:call-template name="members:input-password-confirm">
			<xsl:with-param name="event" select="$event"/>
			<xsl:with-param name="mode" select="'edit'"/>
		</xsl:call-template>
		<xsl:call-template name="members:input-recovery-code">
			<xsl:with-param name="event" select="$event"/>
			<xsl:with-param name="value" select="$url-code"/>
		</xsl:call-template>
		<xsl:call-template name="members:input-submit">
			<xsl:with-param name="event" select="$event"/>
			<xsl:with-param name="redirect" select="substring-before($current-url, '?')"/>
		</xsl:call-template>
	</form>

</xsl:template>

</xsl:stylesheet>
