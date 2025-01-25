import { mailtrapClient, sender } from "../config/mailtrap.js";

const sendWelcomeEmail = async (email, name) => {
	const recipient = [{ email }];

	try {
		const response = await mailtrapClient.send({
			from: sender,
			to: recipient,
			subject: "Welcome to Mailtrap",
			text: `Hi ${name}, welcome to Mailtrap!`,
		});

		console.log("Welcome email sent successfully", response);
	} catch (error) {
		console.error(`Error sending welcome email`, error);

		throw new Error(`Error sending welcome email: ${error}`);
	}
};

export default sendWelcomeEmail;