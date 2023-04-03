package ga.heaven.configuration;

public interface Constants {

    /**
     * Dynamic endpoints
     */
    String SHELTER_EPT = "shelter";
    String REPORT_EPT = "submit_report";
    String START_EPT = "start";
    String VOLUNTEER_REQUEST_EPT = "call_volunteer";
    Long ENDPOINT_LIST = 0L;
    Long MAIN_MENU_LEVEL = 1L;
    Long SHELTERS_MENU_LEVEL = 2L;
    Long SHELTER_INFO_MENU_LEVEL = 3L;
    Long DATING_INFO_MENU_LEVEL = 4L;
    Long REPORTS_MENU_LEVEL = 5L;

    /**
     * Commands
     */
    String BASE_URL = "https://api.telegram.org/bot";
    
    //String DATING_RULES_CMD = "/dating_rules";
    
/*    String REPORT_SUBMIT_CMD = "/submit_report";
    String DOCUMENTS_CMD = "/documents"; // команда выдать список документов
    String TRANSPORT_CMD = "/transport"; // команда выдать список документов
    String COMFORT_YOUNG_CMD = "/comfort_young"; // команда выдать рекомендации по обустройству дома для питомца
    String COMFORT_ADULT_CMD = "/comfort_adult"; // команда выдать рекомендации по обустройству дома для взрослой собаки
    String COMFORT_HANDICAPPED_CMD = "/comfort_handicapped"; // команда выдать рекомендации по обустройству дома для питомца с ограниченными возможностями
    String CYNOLOGIST_ADVICE_CMD = "/cynologist_advice"; // команда выдать рекомендации кинолога
    String CYNOLOGISTS_LIST_CMD = "/cynologists_list"; // команда выдать рекомендации кинолога
    String REASONS_REFUSAL_CMD = "/reasons_refusal"; // команда выдать причины отказа*/
/*    String SHELTER_INFO_CMD = "/shelter_info"; // команда выдать информацию о приюте
    String SHELTER_ADDRESS_CMD = "/address"; // команда выдать адрес приюта
    String SHELTER_SAFETY_CMD = "/security_contact"; // команда выдать правила поведения на территории приюта
    String SHELTER_LEAVE_CONTACT_CMD = "/leave_contact"; // команда получить контакты от пользователя*/
    String SHELTER_INFO_EPT = "shelter_info"; // команда выдать информацию о приюте
    String SHELTER_ADDRESS_EPT = "address"; // команда выдать адрес приюта
    String SHELTER_SAFETY_EPT = "safety"; // команда выдать правила поведения на территории приюта
    String SHELTER_SEND_CONTACT_EPT = "send_contact"; // команда получить контакты от пользователя

    /**
     * Info fields
     */
    String COMMON_INFO_FIELD = "common_info";
    String DATING_RULES_FIELD = "dating_rules";
    String DOCUMENTS_FIELD = "documents"; // необходимые документы
    String TRANSPORT_FIELD = "transport"; // правила перевозки
    String COMFORT_PET_FIELD = "comfort_pet"; // рекомендации по обустройству дома для питомца
    String COMFORT_DOG_FIELD = "comfort_dog"; // рекомендации по обустройству дома для взрослой собаки
    String COMFORT_HANDICAPPED_FIELD = "comfort_handicapped"; // рекомендации по обустройству дома для питомца с ограниченными возможностями
    String CYNOLOGIST_ADVICE_FIELD = "cynologist_advice"; // рекомендации кинолога
    String CYNOLOGISTS_LIST_FIELD = "cynologists_list"; // список кинологов
    String REASONS_REFUSAL_FIELD = "reasons_refusal"; // список кинологов

    /**
     * Messages
     */
    String CR = "\r\n";
    String SHELTER_CHOOSE_MSG = "Please select which shelter you are interested in";
    String SHELTER_SEND_NAME_MSG = "Please enter your name (Ivanov Ivan Ivanovich / Ivanov Ivan / Ivan)";
    String SHELTER_SEND_PHONE_MSG = "Please enter your phone number (no more than 12 characters)";
    String SHELTER_SEND_ADDRESS_MSG = "Please enter your address";
    String SHELTER_CONTACT_SAVED = "Thank you, contact details saved";
    String SHELTER_NOT_FOUND = "Shelter not selected";
    String SHELTER_INFO_NOT_FOUND = "At the shelter the field \"description\" is not filled";
    String SHELTER_ADDRESS_NOT_FOUND = "At the shelter the field \"address\" is not filled";
    String SHELTER_RULES_NOT_FOUND = "At the shelter the field \"rules\" is not filled";
    String DATING_RULES_NOT_FOUND = "No information found regarding handling pets. Please contact the administration.";
    String DOCUMENTS_NOT_FOUND = "The list of documents is missing. Please contact the administration.";
    String TRANSPORT_NOT_FOUND = "Transportation rules not found. Please contact the administration.";
    String COMFORT_PET_NOT_FOUND = "Rules for arranging a pet's home not found. Please contact the administration.";
    String COMFORT_DOG_NOT_FOUND = "Rules for arranging a dog's home not found. Please contact the administration.";
    String COMFORT_HANDICAPPED_NOT_FOUND = "Rules for arranging a handicapped pet's home not found. Please contact the administration.";
    String CYNOLOGIST_ADVICE_NOT_FOUND = "The dog handler's advice was not found. Please contact the administration.";
    String CYNOLOGIST_LIST_NOT_FOUND = "The list of dog handlers was not found. Please contact the administration.";
    String REASONS_REFUSAL_NOT_FOUND = "The list of reasons for refusal was not found. Please contact the administration.";
    String REPORT_CHOICE_PET = "Select the pet for which you want to submit a report";
    String REPORT_WAIT_REPORT = "Waiting for a pet report ";
    String REPORT_ACCEPTED = "<b>Report accepted</b>";
    String REPORT_NOT_ACCEPTED = "<b>Report not accepted</b>" + CR;
    String REPORT_SUBMIT_TEXT = "Submit the following information:" + CR +
            "1. Animal diet." + CR +
            "2. General well-being and getting used to a new place." + CR +
            "3. Change in behavior: abandoning old habits, acquiring new ones.";
    String REPORT_NOT_ACCEPTED_DESCRIPTION_REQUIRED = REPORT_NOT_ACCEPTED + REPORT_SUBMIT_TEXT;
    String REPORT_SUBMIT_PHOTO = "Submit a photo of your pet";
    String REPORT_NOT_ACCEPTED_PHOTO_REQIRED = REPORT_NOT_ACCEPTED + REPORT_SUBMIT_PHOTO;
    String REPORT_DECISION_DATE = "You must submit reports by ";
    String REPORT_PHOTO_ADD_TO_REPORT = "Photo added to the report";
    String REPORT_UNRECOGNIZED_PHOTO = "Unrecognized photo";
}
