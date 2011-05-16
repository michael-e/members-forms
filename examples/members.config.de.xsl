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

			<field type="username" handle="benutzername">
				<label>Benutzername</label>
				<errors>
					<benutzername type="missing" message="Benutzername is a required field.">Benutzername ist ein Pflichtfeld.</benutzername>
					<benutzername type="invalid" message="Benutzername contains invalid characters.">Der Benutzername ist ungültig. Er muss mindestens 4 Zeichen lang sein und darf nur aus Buchstaben, Zahlen und Minuszeichen (-) bestehen.</benutzername>
					<benutzername type="invalid" message="Benutzername is already taken.">Benutzername ist bereits vergeben.</benutzername>
					<benutzername type="invalid" message="Member not found.">Benutzer nicht gefunden.</benutzername>
					<error type="invalid" message="No Identity field found.">Benutzername ist ein Pflichtfeld.</error>

					<benutzername type="missing" message="Benutzername ist ein Pflichtfeld.">Benutzername ist ein Pflichtfeld.</benutzername>
					<benutzername type="invalid" message="Benutzername enthält ungültige Zeichen.">Der Benutzername ist ungültig. Er muss mindestens 4 Zeichen lang sein und darf nur aus Buchstaben, Zahlen und Minuszeichen (-) bestehen.</benutzername>
					<benutzername type="invalid" message="Benutzername ist bereits vergeben.">Benutzername ist bereits vergeben.</benutzername>
					<benutzername type="invalid" message="Benutzer nicht gefunden.">Benutzer nicht gefunden.</benutzername>
					<error type="invalid" message="Kein Identitätsfeld gefunden.">Benutzername ist ein Pflichtfeld.</error>
				</errors>
			</field>
			<field type="email" handle="e-mail">
				<label>E-Mail</label>
				<errors>
					<e-mail type="missing" message="E-Mail is a required field.">E-Mail ist ein Pflichtfeld.</e-mail>
					<e-mail type="invalid" message="E-Mail is already taken.">E-Mail-Adresse ist bereits vergeben.</e-mail>
					<e-mail type="invalid" message="E-Mail contains invalid characters.">E-Mail ist ungültig.</e-mail>
					<e-mail type="invalid" message="Member not found.">Benutzer nicht gefunden.</e-mail>

					<e-mail type="missing" message="E-Mail ist ein Pflichtfeld.">E-Mail ist ein Pflichtfeld.</e-mail>
					<e-mail type="invalid" message="E-Mail ist bereits vergeben.">E-Mail-Adresse ist bereits vergeben.</e-mail>
					<e-mail type="invalid" message="E-Mail enthält ungültige Zeichen.">E-Mail ist ungültig.</e-mail>
					<e-mail type="invalid" message="Benutzer nicht gefunden.">Benutzer nicht gefunden.</e-mail>
				</errors>
			</field>
			<field type="password" handle="passwort">
				<label>
					<new>Passwort</new>
					<edit>Neues Passwort</edit>
					<login>Passwort <small>(<a href="/benutzer/passwort-vergessen/">Passwort vergessen?</a>)</small></login>
				</label>
				<errors>
					<passwort type="missing" message="Passwort is a required field.">Passwort ist ein Pflichtfeld.</passwort>
					<passwort type="invalid" message="Passwort is too short. It must be at least 6 characters.">Passwort ist zu kurz. Es muss mindestens 6 Zeichen lang sein.</passwort>
					<passwort type="invalid" message="Passwort is not strong enough.">Passwort ist nicht sicher genug.</passwort>
					<passwort type="invalid" message="Invalid Passwort.">Ungültiges Passwort.</passwort>

					<passwort type="missing" message="Passwort ist ein Pflichtfeld.">Passwort ist ein Pflichtfeld.</passwort>
					<passwort type="invalid" message="Passwort ist zu kurz. Es muss mindestens 6 Zeichen lang sein.">Passwort ist zu kurz. Es muss mindestens 6 Zeichen lang sein.</passwort>
					<passwort type="invalid" message="Passwort ist nicht sicher genug.">Passwort ist nicht sicher genug.</passwort>
					<passwort type="invalid" message="Ungültiges Passwort.">Ungültiges Passwort.</passwort>
				</errors>
			</field>
			<field type="password-confirm">
				<label>
					<new>Passwort wiederholen</new>
					<edit>Neues Passwort bestätigen</edit>
				</label>
				<errors>
					<passwort type="invalid" message="Passwort confirmation does not match.">Passwort-Bestätigung stimmt nicht.</passwort>
					<passwort type="invalid" message="Passwort is too short. It must be at least 6 characters."/>
					<passwort type="invalid" message="Passwort is not strong enough."/>

					<passwort type="invalid" message="Passwort-Bestätigung stimmt nicht.">Passwort-Bestätigung stimmt nicht.</passwort>
					<passwort type="invalid" message="Passwort ist zu kurz. Es muss mindestens 6 Zeichen lang sein."/>
					<passwort type="invalid" message="Passwort ist nicht sicher genug."/>
				</errors>
			</field>
			<field type="recovery-code">
				<label>Notfallcode</label>
				<errors>
					<passwort type="invalid" message="No recovery code found.">Der Notfallcode ist ungültig oder abgelaufen.</passwort>

					<passwort type="invalid" message="Kein Notfallcode gefunden.">Der Notfallcode ist ungültig oder abgelaufen.</passwort>
				</errors>
			</field>
			<field type="activation" handle="aktivierung">
				<label>Aktivierungscode</label>
				<errors>
					<aktivierung type="missing" message="Aktivierung is a required field.">Aktivierungscode ist ein Pflichtfeld.</aktivierung>
					<aktivierung type="invalid" message="Activation error. Code was invalid or has expired.">Aktivierungsfehler. Der Aktivierungscode ist ungültig oder abgelaufen.</aktivierung>
					<aktivierung type="invalid" message="Member is already activated.">Der Benutzer ist bereits aktiviert.</aktivierung>
					<aktivierung type="invalid" message="Member is not activated.">Der Benutzer ist nicht aktiviert.</aktivierung>
					<error type="invalid" message="No Activation field found.">Aktivierungscode ist ein Pflichtfeld.</error>

					<aktivierung type="missing" message="Aktivierung ist ein Pflichtfeld.">Aktivierungscode ist ein Pflichtfeld.</aktivierung>
					<aktivierung type="invalid" message="Aktivierungsfehler. Dieser Code ist ungültig oder abgelaufen.">Aktivierungsfehler. Der Aktivierungscode ist ungültig oder abgelaufen.</aktivierung>
					<aktivierung type="invalid" message="Mitglied ist bereits aktiviert.">Der Benutzer ist bereits aktiviert.</aktivierung>
					<aktivierung type="invalid" message="Mitglied ist nicht aktiviert.">Der Benutzer ist nicht aktiviert.</aktivierung>
					<error type="invalid" message="Kein Aktivierungsfeld gefunden.">Aktivierungscode ist ein Pflichtfeld.</error>
				</errors>
			</field>

			<!-- Dummy error field; this will handle generic errors. -->
			<field type="error">
				<errors>
					<error type="invalid" message="No Authentication field found.">Der aktive Mitgliederbereich hat kein Passwort-Feld.</error>
					<error type="invalid" message="You cannot generate a recovery code while being logged in.">Ein Notfallcode kann nicht erzeugt werden wenn man angemeldet ist. Sie müssen sich vorher abmelden!</error>

					<error type="invalid" message="Kein Authentifizierungsfeld gefunden.">Der aktive Mitgliederbereich hat kein Passwort-Feld.</error>
					<error type="invalid" message="Ein Notfallcode kann nicht erzeugt werden wenn man angemeldet ist.">Ein Notfallcode kann nicht erzeugt werden wenn man angemeldet ist. Sie müssen sich vorher abmelden!</error>
				</errors>
			</field>
		</fields>

		<events>
			<event handle="members-new" submit-value="Registrieren">
				<messages>
					<success><p>Die Registrierung war erfolgreich.</p></success>
					<error><p>Probleme sind aufgetreten.</p></error>
				</messages>
				<filter handle="etm-members-send-activation-code">
					<messages>
						<passed><p>Ein E-Mail wurde verschickt. Sollte es in den nächsten Minuten nicht bei Ihnen ankommen, benachrichtigen Sie bitte den Webmaster unter <a href="mailto:webmaster@example.com">webmaster@example.com</a>.</p></passed>
						<failed><p>Es gab ein Problem beim E-Mail-Versand. Bitte benachrichtigen Sie den Webmaster unter <a href="mailto:webmaster@example.com">webmaster@example.com</a>.</p></failed>
					</messages>
				</filter>
				<filter handle="permission">
					<messages>
						<passed/>
						<failed><p>Hallo? Sie wissen doch wohl, dass Sie das nicht dürfen!</p></failed>
					</messages>
				</filter>
			</event>
			<event handle="members-edit" submit-value="Daten speichern">
				<messages>
					<success><p>Die Kontodaten wurden gespeichert.</p></success>
					<error><p>Probleme sind aufgetreten.</p></error>
				</messages>
				<filter handle="permission">
					<messages>
						<passed/>
						<failed><p>Hallo? Sie wissen doch wohl, dass Sie das nicht dürfen!</p></failed>
					</messages>
				</filter>
			</event>
			<event handle="members-activate-account" submit-value="Konto aktivieren">
				<messages>
					<success><p>Die Aktivierung war erfolgreich.</p></success>
					<error><p>Probleme sind aufgetreten.</p></error>
				</messages>
				<filter handle="etm-members-account-activated">
					<messages>
						<passed><p>Ein E-Mail wurde verschickt. Sollte es in den nächsten Minuten nicht bei Ihnen ankommen, benachrichtigen Sie bitte den Webmaster unter <a href="mailto:webmaster@example.com">webmaster@example.com</a>.</p></passed>
						<failed><p>Es gab ein Problem beim E-Mail-Versand. Bitte benachrichtigen Sie den Webmaster unter <a href="mailto:webmaster@example.com">webmaster@example.com</a>.</p></failed>
					</messages>
				</filter>
			</event>
			<event handle="members-regenerate-activation-code" submit-value="Aktivierungscode anfordern">
				<messages>
					<success><p>Ein neuer Aktivierungscode wurde erzeugt.</p></success>
					<error><p>Probleme sind aufgetreten.</p></error>
				</messages>
				<filter handle="etm-members-resend-activation-code">
					<messages>
						<passed><p>Ein E-Mail wurde verschickt. Sollte es in den nächsten Minuten nicht bei Ihnen ankommen, benachrichtigen Sie bitte den Webmaster unter <a href="mailto:webmaster@example.com">webmaster@example.com</a>.</p></passed>
						<failed><p>Es gab ein Problem beim E-Mail-Versand. Bitte benachrichtigen Sie den Webmaster unter <a href="mailto:webmaster@example.com">webmaster@example.com</a>.</p></failed>
					</messages>
				</filter>
			</event>
			<event handle="member-login-info" submit-value="Anmelden">
				<messages>
					<success><p>Sie sind angemeldet.</p></success>
					<error><p>Probleme sind aufgetreten.</p></error>
				</messages>
			</event>
			<event handle="members-generate-recovery-code" submit-value="Notfallcode anfordern">
				<messages>
					<success><p>Ein Notfallcode wurde erzeugt, der es ermöglicht, ein neues Passwort zu vergeben.</p></success>
					<error><p>Probleme sind aufgetreten.</p></error>
				</messages>
				<filter handle="etm-members-send-recovery-code">
					<messages>
						<passed><p>Ein E-Mail wurde verschickt. Sollte es in den nächsten Minuten nicht bei Ihnen ankommen, benachrichtigen Sie bitte den Webmaster unter <a href="mailto:webmaster@example.com">webmaster@example.com</a>.</p></passed>
						<failed><p>Es gab ein Problem beim E-Mail-Versand. Bitte benachrichtigen Sie den Webmaster unter <a href="mailto:webmaster@example.com">webmaster@example.com</a>.</p></failed>
					</messages>
				</filter>
			</event>
			<event handle="members-reset-password" submit-value="Passwort speichern">
				<messages>
					<success><p>Das neue Passwort wurde erfolgreich gespeichert. Sie sind nun eingeloggt.</p></success>
					<error><p>Probleme sind aufgetreten.</p></error>
				</messages>
			</event>
		</events>
	</data>
</xsl:variable>

</xsl:stylesheet>