<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	xmlns:members="http://michael-eichelsdoerfer.de/xslt/members"
	extension-element-prefixes="exsl members">

<xsl:import href="members-forms/members.forms.xsl"/>

<xsl:param name="url-id"/>
<xsl:param name="url-code"/>

<xsl:template name="members-form-activate-account">

	<xsl:variable name="event" select="'members-activate-account'"/>

	<xsl:call-template name="members:validate">
		<xsl:with-param name="event" select="$event"/>
	</xsl:call-template>

	<form action="" method="post">
		<xsl:call-template name="members:input-identity">
			<xsl:with-param name="event" select="$event"/>
			<xsl:with-param name="value" select="$url-id"/>
		</xsl:call-template>
		<xsl:call-template name="members:input">
			<xsl:with-param name="field" select="'activation'"/>
			<xsl:with-param name="event" select="$event"/>
			<xsl:with-param name="value" select="$url-code"/>
		</xsl:call-template>
		<xsl:call-template name="members:input-submit">
			<xsl:with-param name="event" select="$event"/>
		</xsl:call-template>
	</form>

</xsl:template>

</xsl:stylesheet>
