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
				<label>Имя пользователя</label>
				<errors>
					<username type="missing" message="Имя пользователя обязательно для заполнения."/>
					<username type="invalid" message="Имя пользователя содержит недопустимые символы."/>
					<username type="invalid" message="Пользователь с таким именем уже существует."/>
					<username type="invalid" message="Пользователь не найден."/>
					<error type="invalid" message="Не найден пользователь.">'Имя пользователя' обязательно для заполнения.</error>
					
					<username type="missing" message="USERNAME is a required field.">Имя пользователя обязательно для заполнения
					<username type="invalid" message="USERNAME contains invalid characters.">Имя пользователя содержит недопустимые символы. Поле должно содержать не менее 4х символов.</username>
					<username type="invalid" message="USERNAME is already taken.">Пользователь с таким именем уже существует</username>
					<username type="invalid" message="Member not found.">Пользователь не найден.</username>
					<error type="invalid" message="No Identity field found.">'Имя пользователя' обязательно для заполнения.</error>
				</errors>
			</field>
			<field type="email" handle="email">
				<label>Электронная почта</label>
				<errors>
					<email type="missing" message="Электронная почта обязательна для заполнения."/>
					<email type="invalid" message="Такая электронная почта уже зарегистрирована."/>
					<email type="invalid" message="В поле электронная почта есть недопустимые символы.">В поле электронная почта есть недопустимые символы.</e-mail>
					<email type="invalid" message="Пользователь с такой электронной почтой не найден."/>
					
					<email type="missing" message="E-Mail is a required field.">Электронная почта обязательна для заполнения.</email>
					<email type="invalid" message="E-Mail is already taken.">Такая электронная почта уже зарегистрирована.</email>
					<email type="invalid" message="E-Mail contains invalid characters.">В поле электронная почта есть недопустимые символы.</e-mail>
					<email type="invalid" message="Member not found.">Пользователь с такой электронной почтой не найден.</email>
				</errors>
			</field>
			<field type="password" handle="password">
				<label>
					<new>Пароль</new>
					<edit>Новый пароль</edit>
					<login>Пароль <small>(<a href="/members/forgot-password/">Забыли пароль?</a>)</small></login>
				</label>
				<errors>
					<password type="missing" message="Пароль обязателен для заполнения."/>
					<password type="invalid" message="Слишком короткий пароль. Должно быть как минимум 6ть символов."/>
					<password type="invalid" message="Пароль недостаточно защищенный."/>
					<password type="invalid" message="Неверный пароль."/>
					
					<password type="missing" message="Password is a required field.">Пароль обязателен для заполнения.</password>
					<password type="invalid" message="Password is too short. It must be at least 6 characters.">Слишком короткий пароль. Должно быть как минимум 6ть символов.</password>
					<password type="invalid" message="Password is not strong enough.">Пароль недостаточно защищенный.</password>
					<password type="invalid" message="Invalid Password.">Неверный пароль.</password>
				</errors>
			</field>
			<field type="password-confirm">
				<label>
					<new>Подтверждение пароля</new>
					<edit>Подтверждение нового пароля</edit>
				</label>
				<errors>
					<password type="invalid" message="Подтверждение пароля не совпадает."/>
					<password type="invalid" message="Пароль слишком короткий. Должно быть как мимнимум 6ть символов."/>
					<password type="invalid" message="Пароль недостаточно защищенный."/>
					
					
					
					<password type="invalid" message="Password confirmation does not match.">Подтверждение пароля не совпадает.</password>
					<password type="invalid" message="Password is too short. It must be at least 6 characters.">Пароль слишком короткий. Должно быть как мимнимум 6ть символов.</password>
					<password type="invalid" message="Password is not strong enough.">Пароль недостаточно защищенный.</password>
				</errors>
			</field>
			<field type="recovery-code">
				<label>Код восстановления</label>
				<errors>
					<password type="invalid" message="Не найден код восстановления.">Код восстановления пароля устарел.</password>
				</errors>
			</field>
			<field type="activation" handle="activation">
				<label>Код активации</label>
				<errors>
					<activation type="missing" message="Код активации обязательное поле."/>
					<activation type="invalid" message="Ошибка в коде активации. Код активации неверный или устарел."/>
					<activation type="invalid" message="Пользователь уже активирован."/>
					<activation type="invalid" message="Пользователь не активный."/>
					<error type="invalid" message="Не заполнен код восстановления.">Код активации обязателен для заполнения.</error>
					
					<activation type="missing" message="Activation Code is a required field.">Код активации обязательное поле.</activation>
					<activation type="invalid" message="Activation error. Code was invalid or has expired.">Ошибка в коде активации. Код активации неверный или устарел.</activation>
					<activation type="invalid" message="Member is already activated.">Пользователь уже активирован.</activation>
					<activation type="invalid" message="Member is not activated.">Пользователь не активный.</activation>
					<error type="invalid" message="No Activation field found.">Код активации обязателен для заполнения.</error>
				</errors>
			</field>

			<!-- Dummy error field; this will handle generic errors. -->
			<field type="error">
				<errors>
					<error type="invalid" message="Не введен ни один признак идентификации пользователя.">Для пользователя не определено поле с паролем.</error>
					<error type="invalid" message="Вы не можете запросить код восстановления пароля, пока залогинены."/>
					
					<error type="invalid" message="No Authentication field found.">Для пользователя не определено поле с паролем.</error>
					<error type="invalid" message="You cannot generate a recovery code while being logged in.">Вы не можете запросить код восстановления пароля, пока залогинены.</error>
				</errors>
			</field>
		</fields>

		<events>
			<event handle="members-new" submit-value="Register">
				<messages>
					<success><p>Регистрация успешно завершена.</p></success>
					<error><p>Во время регистрации обнаружены ошибки.</p></error>
				</messages>
				<filter handle="etm-members-send-activation-code">
					<messages>
						<success><p>На ваш электронный адрес отправлено письмо с подтверждением регистрации. Если, через некоторое время, Вы так и не обнаружите письмо с подтверждением регистрации, пожалуйста, свяжитесь с администратором по следующему адресу: <a href="mailto:webmaster@example.com">webmaster@example.com</a>.</p></success>
						<error><p>Во время отправки письма о подтверждении регистрации произошла ошибка.</p></error>
					</messages>
				</filter>
				<filter handle="permission">
					<messages>
						<passed/>
						<error><p>Похоже у вас недостаточно прав, для просмотра этой страницы.</p></error>
					</messages>
				</filter>
			</event>
			<event handle="members-edit" submit-value="Save">
				<messages>
					<success><p>Ваш профиль сохранен.</p></success>
					<error><p>Во время сохранения профиля обнаружены ошибки.</p></error>
				</messages>
				<filter handle="permission">
					<messages>
						<passed/>
						<error><p>Похоже у вас недостаточно прав для этого действия!</p></error>
					</messages>
				</filter>
			</event>
			<event handle="members-activate-account" submit-value="Activate Account">
				<messages>
					<success><p>Активация успешно проведена.</p></success>
					<error><p>Во время активации были обнаружены ошибки.</p></error>
				</messages>
				<filter handle="etm-members-account-activated">
					<messages>
						<success><p>На Ваш электронный адрес было отправлено подтверждение о активации вашего аккаунта.</p></success>
						<error><p>Во время отправки подтверждения об активации вашего аккаунта были обнаружены ошибки.</p></error>
					</messages>
				</filter>
			</event>
			<event handle="members-regenerate-activation-code" submit-value="Request Activation Code">
				<messages>
					<success><p>Новый код активации был создан.</p></success>
					<error><p>Во время создания нового кода активации были обнаружены ошибки.</p></error>
				</messages>
				<filter handle="etm-members-resend-activation-code">
					<messages>
						<success><p>Новый код активации был отправлен вам на электронную почту.</p></success>
						<error><p>Во время отправки нового кода активации были обнаружены ошибки.</p></error>
					</messages>
				</filter>
			</event>
			<event handle="member-login-info" submit-value="Log in">
				<messages>
					<success><p>Вход выполнен.</p></success>
					<error><p>Вход не выполнен, были обнаружены ошибки.</p></error>
				</messages>
			</event>
			<event handle="members-generate-recovery-code" submit-value="Request Recovery Code">
				<messages>
					<success><p>код восстановления учетной записи был создан.</p></success>
					<error><p>Во время создания кода восстановления учетной записи были обнаружены ошибки.</p></error>
				</messages>
				<filter handle="etm-members-send-recovery-code">
					<messages>
						<success><p>На Ваш электронный адрес был отправлен код восстановления учетной записи.</p></success>
						<error><p>Во время отправки кода восстановления учетной записи были обнаружены ошибки.</p></error>
					</messages>
				</filter>
			</event>
			<event handle="members-reset-password" submit-value="Save Passsword">
				<messages>
					<!--
						Due to the auto-login feature of the Reset Password
						event you will probably use a redirect on form submit.
						This would mean that the success message will never
						be rendered.
					-->
					<success><p>Ваш новый пароль сохранен.</p></success>
					<error><p>Во время сохранения нового пароля обнаружены ошибки.</p></error>
				</messages>
			</event>
		</events>
	</data>
</xsl:variable>

</xsl:stylesheet>