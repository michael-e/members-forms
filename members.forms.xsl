<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	xmlns:members="http://michael-eichelsdoerfer.de/xslt/members"
	extension-element-prefixes="exsl members">

<!--
	Configuration: Load the (language) configuration file and specify the
	class which should be added to invalid form elements.
-->
<xsl:import href="../members.config.xsl"/>
<xsl:param name="members:invalid-class" select="'invalid'"/>

<!-- Changing anything below this line is at your own risk. -->

<xsl:variable name="members:config" select="exsl:node-set($members-config)"/>
<xsl:variable name="members:use-password-postback" select="boolean($members:config/data/security/use-password-postback = 'true')"/>

<xsl:template name="members:input">
	<xsl:param name="type" select="'text'"/>
	<xsl:param name="event"/>
	<xsl:param name="value"/>
	<xsl:param name="field"/>
	<xsl:param name="field-label" select="$members:config/data/fields/field[@type=$field]/label"/>
	<xsl:param name="field-handle" select="$members:config/data/fields/field[@type=$field]/@handle"/>
	<xsl:param name="id"/>
	<xsl:param name="name" select="concat('fields[', $field-handle, ']')"/>
	<xsl:param name="xml-post-value" select="/data/events/*[name()=$event]/post-values/*[name()=$field-handle]"/>
	<xsl:variable name="final-id">
		<xsl:choose>
			<xsl:when test="$id != ''">
				<xsl:value-of select="$id"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat('fields-', $field-handle)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<!--
		Check if the field's configuration contains an element with
		the same message attribute value as found in the event XML
		response. The name of the node does not matter (may be <error/>
		as well).
	-->
	<xsl:variable name="invalid" select="boolean(/data/events/*[name()=$event]/*/@message = $members:config/data/fields/field[@type=$field]/errors/*/@message)"/>
	<div class="input">
		<label for="{$final-id}">
			<xsl:if test="$invalid">
				<xsl:attribute name="class">
					<xsl:value-of select="$members:invalid-class"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:copy-of select="$field-label/*|$field-label/text()"/>
		</label>
		<input type="{$type}" id="{$final-id}" name="{$name}">
			<xsl:if test="$invalid">
				<xsl:attribute name="class">
					<xsl:value-of select="$members:invalid-class"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="$xml-post-value != ''">
					<xsl:attribute name="value"><xsl:value-of select="$xml-post-value"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="$value != ''">
					<xsl:attribute name="value"><xsl:value-of select="$value"/></xsl:attribute>
				</xsl:when>
			</xsl:choose>
		</input>
	</div>
</xsl:template>

<xsl:template name="members:input-password">
	<xsl:param name="event"/>
	<xsl:param name="value"/>
	<xsl:param name="id"/>
	<xsl:param name="mode"/>
		<xsl:choose>
			<xsl:when test="$mode='login'">
				<xsl:call-template name="members:input">
					<xsl:with-param name="type" select="'password'"/>
					<xsl:with-param name="event" select="$event"/>
					<xsl:with-param name="value" select="$value"/>
					<xsl:with-param name="id" select="$id"/>
					<xsl:with-param name="field" select="'password'"/>
					<xsl:with-param name="field-label" select="$members:config/data/fields/field[@type='password']/label/login"/>
					<xsl:with-param name="xml-post-value">
						<xsl:if test="$members:use-password-postback">
							<xsl:value-of select="/data/events/*[name()=$event]/post-values/*[name()=$members:config/data/fields/field[@type='password']/@handle]"/>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="members:input">
					<xsl:with-param name="type" select="'password'"/>
					<xsl:with-param name="event" select="$event"/>
					<xsl:with-param name="value" select="$value"/>
					<xsl:with-param name="id" select="$id"/>
					<xsl:with-param name="field" select="'password'"/>
					<xsl:with-param name="field-label" select="$members:config/data/fields/field[@type='password']/label/*[name()=$mode]"/>
					<xsl:with-param name="field-handle" select="concat($members:config/data/fields/field[@type='password']/@handle, '-password')"/>
					<xsl:with-param name="name" select="concat('fields[', $members:config/data/fields/field[@type='password']/@handle, '][password]')"/>
					<xsl:with-param name="xml-post-value">
						<xsl:if test="$members:use-password-postback">
							<xsl:value-of select="/data/events/*[name()=$event]/post-values/*[name()=$members:config/data/fields/field[@type='password']/@handle]/password"/>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
</xsl:template>

<xsl:template name="members:input-password-confirm">
	<xsl:param name="event"/>
	<xsl:param name="value"/>
	<xsl:param name="id"/>
	<xsl:param name="mode"/>
	<xsl:call-template name="members:input">
		<xsl:with-param name="type" select="'password'"/>
		<xsl:with-param name="event" select="$event"/>
		<xsl:with-param name="value" select="$value"/>
		<xsl:with-param name="id" select="$id"/>
		<xsl:with-param name="field" select="'password-confirm'"/>
		<xsl:with-param name="field-label" select="$members:config/data/fields/field[@type='password-confirm']/label/*[name()=$mode]"/>
		<xsl:with-param name="field-handle" select="concat($members:config/data/fields/field[@type='password']/@handle, '-confirm')"/>
		<xsl:with-param name="name" select="concat('fields[', $members:config/data/fields/field[@type='password']/@handle, '][confirm]')"/>
		<xsl:with-param name="xml-post-value">
			<xsl:if test="$members:use-password-postback">
				<xsl:value-of select="/data/events/*[name()=$event]/post-values/*[name()=$members:config/data/fields/field[@type='password']/@handle]/confirm"/>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="members:input-recovery-code">
	<xsl:param name="event"/>
	<xsl:param name="value"/>
	<xsl:param name="id"/>
	<xsl:call-template name="members:input">
		<xsl:with-param name="event" select="$event"/>
		<xsl:with-param name="value" select="$value"/>
		<xsl:with-param name="id" select="$id"/>
		<xsl:with-param name="field" select="'recovery-code'"/>
		<xsl:with-param name="field-handle" select="concat($members:config/data/fields/field[@type='password']/@handle, '-recovery-code')"/>
		<xsl:with-param name="name" select="concat('fields[', $members:config/data/fields/field[@type='password']/@handle, '][recovery-code]')"/>
		<xsl:with-param name="xml-post-value">
			<xsl:if test="$members:use-password-postback">
				<xsl:value-of select="/data/events/*[name()=$event]/post-values/*[name()=$members:config/data/fields/field[@type='password']/@handle]/recovery-code"/>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="members:input-identity">
	<xsl:param name="event"/>
	<xsl:param name="value"/>
	<xsl:param name="id"/>
	<xsl:call-template name="members:input">
		<xsl:with-param name="event" select="$event"/>
		<xsl:with-param name="value" select="$value"/>
		<xsl:with-param name="id" select="$id"/>
		<xsl:with-param name="field" select="$members:config/data/fields/field[@type='identity']/@link"/>
	</xsl:call-template>
</xsl:template>

<xsl:template name="members:input-submit">
	<xsl:param name="event"/>
	<xsl:param name="name" select="concat('action[', $event, ']')"/>
	<xsl:param name="id"/>
	<xsl:param name="value" select="$members:config/data/events/event[@handle=$event]/@submit-value"/>
	<xsl:param name="redirect"/>
	<div class="input submit">
		<xsl:if test="$redirect != ''">
			<input type="hidden" name="redirect" value="{$redirect}"/>
		</xsl:if>
		<input type="submit" name="{$name}" value="{$value}">
			<xsl:if test="$id != ''">
				<xsl:attribute name="id">
					<xsl:value-of select="$id"/>
				</xsl:attribute>
			</xsl:if>
		</input>
	</div>
</xsl:template>

<xsl:template name="members:validate">
	<xsl:param name="event"/>
	<xsl:param name="xml-event" select="/data/events/*[name()=$event]"/>
	<xsl:choose>
		<xsl:when test="$xml-event/filter[@name='permission' and @status='failed']">
			<xsl:apply-templates select="$xml-event/filter[@name='permission' and @status='failed']" mode="members:validation-summary"/>
		</xsl:when>
		<xsl:when test="$event='member-login-info' and not($xml-event/@result)"/>
		<xsl:otherwise>
			<xsl:apply-templates select="$xml-event" mode="members:validation-summary"/>
			<xsl:apply-templates select="$xml-event/filter[@name=$members:config/data/events/event[@handle=$event]/filter/@handle]" mode="members:validation-summary"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="events/*" mode="members:validation-summary">
	<xsl:param name="event" select="name()"/>
	<xsl:param name="result" select="@result"/>
	<xsl:param name="message">
		<xsl:variable name="custom-message" select="$members:config/data/events/event[@handle=$event]/messages/*[name()=$result]"/>
		<xsl:choose>
			<xsl:when test="$custom-message">
				<xsl:copy-of select="$custom-message"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="message"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:param>
	<xsl:if test="$message!=''">
		<div class="validation-summary {$result}">
			<xsl:apply-templates select="exsl:node-set($message)" mode="members:html-node"/>
			<xsl:if test="*[@message]">
				<ul>
					<xsl:apply-templates select="*/@message" mode="members:render-field-message"/>
				</ul>
			</xsl:if>
		</div>
	</xsl:if>
</xsl:template>

<xsl:template match="@message" mode="members:render-field-message">
	<xsl:param name="field" select="name(..)"/>
	<xsl:param name="this-message" select="."/>
	<xsl:param name="message">
		<!--
			Find message with the correct node name.
			The placement inside the config file (which field?) must not
			matter here! (This placement only decides rendering of "invalid"
			classes for fields, see 'members:input' template.)
		-->
		<xsl:variable name="custom-message" select="$members:config/data/fields/field/errors/*[name()=$field and @message=$this-message]"/>
		<xsl:choose>
			<xsl:when test="$custom-message!=''">
				<xsl:copy-of select="$custom-message/*|$custom-message/text()"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:param>
	<xsl:if test="$message!=''">
		<li>
			<xsl:copy-of select="$message"/>
		</li>
	</xsl:if>
</xsl:template>

<xsl:template match="filter" mode="members:validation-summary">
	<xsl:param name="event" select="name(..)"/>
	<xsl:param name="filter" select="@name"/>
	<xsl:param name="status" select="@status"/>
	<xsl:param name="result">
		<xsl:choose>
			<xsl:when test="$status='passed'">
				<xsl:value-of select="'success'"/>
			</xsl:when>
			<xsl:when test="$status='failed'">
				<xsl:value-of select="'error'"/>
			</xsl:when>
		</xsl:choose>
	</xsl:param>
	<xsl:param name="message">
		<xsl:variable name="custom-message" select="$members:config/data/events/event[@handle=$event]/filter[@handle=$filter]/messages/*[name()=$status]"/>
		<xsl:choose>
			<xsl:when test="$custom-message">
				<xsl:copy-of select="$custom-message"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:param>
	<xsl:if test="$message!=''">
		<div class="validation-summary {$result}">
			<xsl:apply-templates select="exsl:node-set($message)" mode="members:html-node"/>
		</div>
	</xsl:if>
</xsl:template>

<xsl:template match="*|@*|text()" mode="members:html-node">
	<xsl:choose>
		<xsl:when test="* and not(text())">
			<xsl:copy-of select="*"/>
		</xsl:when>
		<xsl:otherwise>
			<p><xsl:copy-of select="*|@*|text()"/></p>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>