import { mailtrapClient, sender } from "../config/mailtrap.js";

const sendVerificationEmail = async (email, verificationToken) => {
    const recipient = [{ email }];

	try {
		const response = await mailtrapClient.send({
			from: sender,
			to: recipient,
			subject: "Verify your email",
            text: `Hello...\n
					Thank you for your signup! Your Verification code is: \n
					${verificationToken} \n
					Enter this code to the verification page to complete your Registration\n
					This code will expire in 15 minutes for security reason\n`,
			category: "Email Verification",
		});

		console.log("Email sent successfully", response);
	} catch (error) {
		console.error(`Error sending verification`, error);
		throw new Error(`Error sending verification email: ${error}`);
	}
}

export default sendVerificationEmail