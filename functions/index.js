/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp({projectId: 'ziique-7aa1b'});

const firestore = admin.firestore();

exports.setBeatString = functions.https.onCall(async (data, context) => {
    // Check if the session ID is provided
    if (!data.sessionID) {
      throw new functions.https.HttpsError('invalid-argument', 'Session ID is missing.');
    }
  
    try {
      const sessionID = data.sessionID;
      const beatString = data.beatString;
  
      // Create a new document in Firestore with the session ID as the document ID
      await admin.firestore().collection('Sessions').doc(sessionID).update({
        beatString: beatString
      });
  
      return { success: true, message: `Session document created with ID: ${sessionID}` };
    } catch (error) {
      throw new functions.https.HttpsError('internal', 'An error occurred while creating the session document.', error);
    }
  });