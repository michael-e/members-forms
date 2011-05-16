<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:variable name="members-config">
	<data>
		<!--
			This datasource is needed to edit member data.
			See members.form-edit-account.xsl
		-->
		<datasources>
			<member handle="members-1-by-member-id"/>
		</datasources>

		<fields>
			<!--
				Identity field: The 'link' attribute value must be either
				'username' or 'email'.
			-->
			<field type="identity" link="username"/>

			<field type="username" handle="username">
				<label>Username</label>
				<errors>
					<username type="missing" message="USERNAME is a required field."/>
					<username type="invalid" message="USERNAME contains invalid characters.">The username is invalid. It must be at least 4 characters.</benutzername>
					<username type="invalid" message="USERNAME is already taken."/>
					<username type="invalid" message="Member not found."/>
					<error type="invalid" message="No Identity field found."/>'Username' is a required field.</error>
				</errors>
			</field>
			<field type="email" handle="email">
				<label>E-Mail</label>
				<errors>
					<email type="missing" message="E-Mail is a required field."/>
					<email type="invalid" message="E-Mail is already taken."/>
					<email type="invalid" message="E-Mail contains invalid characters.">'Email' does not seem to be a valid address.</e-mail>
					<email type="invalid" message="Member not found."/>
				</errors>
			</field>
			<field type="password" handle="password">
				<label>
					<new>Password</new>
					<edit>New Password</edit>
					<login>Password <small>(<a href="/members/forgot-password/">Forgot Password?</a>)</small></login>
				</label>
				<errors>
					<password type="missing" message="Passwort is a required field."/>
					<password type="invalid" message="Passwort is too short. It must be at least 6 characters."/>
					<password type="invalid" message="Passwort is not strong enough."/>
					<password type="invalid" message="Invalid Passwort."/>
				</errors>
			</field>
			<field type="password-confirm">
				<label>
					<new>Confirm Password</new>
					<edit>Confirm New Password</edit>
				</label>
				<errors>
					<password type="invalid" message="Passwort confirmation does not match."/>
					<password type="invalid" message="Passwort is too short. It must be at least 6 characters."/>
					<password type="invalid" message="Passwort is not strong enough."/>
				</errors>
			</field>
			<field type="recovery-code">
				<label>Recovery Code</label>
				<errors>
					<password type="invalid" message="No recovery code found.">The Recovery Code was invalid or has expired.</passwort>
				</errors>
			</field>
			<field type="activation" handle="activation">
				<label>Activation Code</label>
				<errors>
					<activation type="missing" message="Aktivierung is a required field."/>
					<activation type="invalid" message="Activation error. Code was invalid or has expired."/>
					<activation type="invalid" message="Member is already activated."/>
					<activation type="invalid" message="Member is not activated."/>
					<error type="invalid" message="No Activation field found.">'Activation Code' is a required field.</error>
				</errors>
			</field>

			<!-- Dummy error field; this will handle generic errors. -->
			<field type="error">
				<errors>
					<error type="invalid" message="No Authentication field found.">There is no password field in the active Members section.</error>
					<error type="invalid" message="You cannot generate a recovery code while being logged in."/>
				</errors>
			</field>
		</fields>

		<events>
			<event handle="members-new" submit-value="Register">
				<messages>
					<success><p>Registration was successful.</p></success>
					<error><p>Problems occured.</p></error>
				</messages>
				<filter handle="etm-members-send-activation-code">
					<messages>
						<success><p>An Email has been sent. Should you not receive it in the next couple of minutes, please inform the webmaster at <a href="mailto:webmaster@example.com">webmaster@example.com</a>.</p></success>
						<error><p>There were problems during email sending. Please inform the webmaster at <a href="mailto:webmaster@example.com">webmaster@example.com</a>.</p></error>
					</messages>
				</filter>
				<filter handle="permission">
					<messages>
						<passed/>
						<error><p>Hello? You know that you must not do this!</p></error>
					</messages>
				</filter>
			</event>
			<event handle="members-edit" submit-value="Save">
				<messages>
					<success><p>Account data have been saved.</p></success>
					<error><p>Problems occured.</p></error>
				</messages>
				<filter handle="permission">
					<messages>
						<passed/>
						<error><p>Hello? You know that you must not do this!</p></error>
					</messages>
				</filter>
			</event>
			<event handle="members-activate-account" submit-value="Activate Account">
				<messages>
					<success><p>Activation was successful.</p></success>
					<error><p>Problems occured.</p></error>
				</messages>
				<filter handle="etm-members-account-activated">
					<messages>
						<success><p>An Email has been sent. Should you not receive it in the next couple of minutes, please inform the webmaster at <a href="mailto:webmaster@example.com">webmaster@example.com</a>.</p></success>
						<error><p>There were problems during email sending. Please inform the webmaster at <a href="mailto:webmaster@example.com">webmaster@example.com</a>.</p></error>
					</messages>
				</filter>
			</event>
			<event handle="members-regenerate-activation-code" submit-value="Request Activation Code">
				<messages>
					<success><p>A new activation code has been created.</p></success>
					<error><p>Problems occured.</p></error>
				</messages>
				<filter handle="etm-members-resend-activation-code">
					<messages>
						<success><p>An Email has been sent. Should you not receive it in the next couple of minutes, please inform the webmaster at <a href="mailto:webmaster@example.com">webmaster@example.com</a>.</p></success>
						<error><p>There were problems during email sending. Please inform the webmaster at <a href="mailto:webmaster@example.com">webmaster@example.com</a>.</p></error>
					</messages>
				</filter>
			</event>
			<event handle="member-login-info" submit-value="Anmelden">
				<messages>
					<success><p>You are logged in.</p></success>
					<error><p>Problems occured.</p></error>
				</messages>
			</event>
			<event handle="members-generate-recovery-code" submit-value="Request Recovery Code">
				<messages>
					<success><p>A Recovery Code has been created which allows to set a new password.</p></success>
					<error><p>Problems occured.</p></error>
				</messages>
				<filter handle="etm-members-send-recovery-code">
					<messages>
						<success><p>An Email has been sent. Should you not receive it in the next couple of minutes, please inform the webmaster at <a href="mailto:webmaster@example.com">webmaster@example.com</a>.</p></success>
						<error><p>There were problems during email sending. Please inform the webmaster at <a href="mailto:webmaster@example.com">webmaster@example.com</a>.</p></error>
					</messages>
				</filter>
			</event>
			<event handle="members-reset-password" submit-value="Save Passsword">
				<messages>
					<success><p>Your new password has been saved successfully.</p></success>
					<error><p>Problems occured.</p></error>
				</messages>
			</event>
		</events>
	</data>
</xsl:variable>

</xsl:stylesheet>