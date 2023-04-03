package ga.heaven.service;

import com.pengrad.telegrambot.model.request.InlineKeyboardButton;
import com.pengrad.telegrambot.model.request.InlineKeyboardMarkup;
import ga.heaven.model.*;
import ga.heaven.model.CustomerContext.Context;
import ga.heaven.repository.ShelterRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.Objects;
import java.util.stream.Collectors;

import static ga.heaven.configuration.Constants.*;

@Service
public class AppLogicService {
    private static final Logger LOGGER = LoggerFactory.getLogger(AppLogicService.class);
    private final InfoService infoService;
    private final CustomerService customerService;
    private final MsgService msgService;
    private final ShelterRepository shelterRepository;
    
    public AppLogicService(InfoService infoService, CustomerService customerService, MsgService msgService, ShelterRepository shelterRepository) {
        this.infoService = infoService;
        this.customerService = customerService;
        this.msgService = msgService;
        this.shelterRepository = shelterRepository;
    }
    
    public void initConversation(TgIn in) {
        TgOut out = new TgOut();
        out.tgIn(in)
                .generateMarkup(SHELTERS_MENU_LEVEL);

        //if (Objects.isNull(out.getIn().lastInQueryMessageId())) {
        if (Objects.isNull(out.getIn().getCustomer().getCustomerContext().getShelterId())) {
            out.textBody(infoService.findInfoByArea(COMMON_INFO_FIELD).getInstructions()+"\n");
        }

        out
                .textBody(out.getTextBody() + "Please select a shelter depending on which animal you want to adopt.")
                .send().save();
        LOGGER.debug("initConversation with chatId: {}", in.chatId());
//        LOGGER.debug("TgOut: {}", t);
    }

    public void sendContact(TgIn in, Long recipientChatId, String text) {
        String name = in.message().chat().username();
        InlineKeyboardButton keyboardButton = new InlineKeyboardButton(name + "'s profile "
        ).url("tg://user?id=" + in.chatId());
        InlineKeyboardMarkup keyboardMarkup = new InlineKeyboardMarkup(keyboardButton);
        msgService.sendMsg(recipientChatId, text, keyboardMarkup);
    }


    public void volunteerRequest(TgIn in) {
        
        String shelterSupervisors = in
                .currentShelter(in.getCustomer().getCustomerContext().getShelterId())
                .getVolunteers().stream()
                .map(Volunteer::getName)
                .collect(Collectors.toList()).toString();

        String shelter = in.currentShelter(in.getCustomer().getCustomerContext().getShelterId()).getName();
        String text = "This person want to consult with volunteer supervised " + shelter;
        
        in
        .currentShelter(in.getCustomer().getCustomerContext().getShelterId())
                .getVolunteers()
                .forEach(v -> sendContact(in,v.getChatId(), text))
                
        ;
    
        new TgOut()
                .tgIn(in)
                .generateMarkup(in.getCustomer().getCustomerContext().getCurLevel())
                .textBody("Your request has been accepted.\n" +
                        "You will be contacted by the first free volunteer from the list\n\n " + shelterSupervisors)
                .send()
                .save();
        
    }
    
    /*
    *//**
     * @param chatId Telegram chat id
     * @see #sendMultipurpose(Long, String, String)
     *//*
    public void sendDatingRules(Long chatId) {
        sendMultipurpose(chatId, DATING_RULES_FIELD, DATING_RULES_NOT_FOUND);
    }
    public void sendDatingRules(TgIn in) {
        sendMultipurpose(in, DATING_RULES_FIELD, DATING_RULES_NOT_FOUND);
    }
    *//**
     * @param chatId Telegram chat id
     * @see #sendMultipurpose(Long, String, String)
     *//*
    public void sendDocuments(Long chatId) {
        sendMultipurpose(chatId, DOCUMENTS_FIELD, DOCUMENTS_NOT_FOUND);
    }
    
    *//**
     * @param chatId Telegram chat id
     * @see #sendMultipurpose(Long, String, String)
     *//*
    public void sendTransportRules(Long chatId) {
        sendMultipurpose(chatId, TRANSPORT_FIELD, TRANSPORT_NOT_FOUND);
    }
    
    *//**
     * @param chatId Telegram chat id
     * @see #sendMultipurpose(Long, String, String)
     *//*
    public void sendComfortPet(Long chatId) {
        sendMultipurpose(chatId, COMFORT_PET_FIELD, COMFORT_PET_NOT_FOUND);
    }
    
    *//**
     * @param chatId Telegram chat id
     * @see #sendMultipurpose(Long, String, String)
     *//*
    public void sendComfortDog(Long chatId) {
        sendMultipurpose(chatId, COMFORT_DOG_FIELD, COMFORT_DOG_NOT_FOUND);
    }
    
    *//**
     * @param chatId Telegram chat id
     * @see #sendMultipurpose(Long, String, String)
     *//*
    public void sendComfortHandicapped(Long chatId) {
        sendMultipurpose(chatId, COMFORT_HANDICAPPED_FIELD, COMFORT_HANDICAPPED_NOT_FOUND);
    }
    
    *//**
     * @param chatId Telegram chat id
     * @see #sendMultipurpose(Long, String, String)
     *//*
    public void sendCynologistAdvice(Long chatId) {
        sendMultipurpose(chatId, CYNOLOGIST_ADVICE_FIELD, CYNOLOGIST_ADVICE_NOT_FOUND);
    }
    
    *//**
     * @param chatId Telegram chat id
     * @see #sendMultipurpose(Long, String, String)
     *//*
    public void sendCynologistsList(Long chatId) {
        sendMultipurpose(chatId, CYNOLOGISTS_LIST_FIELD, CYNOLOGIST_LIST_NOT_FOUND);
    }
    
    *//**
     * @param chatId Telegram chat id
     * @see #sendMultipurpose(Long, String, String)
     *//*
    public void sendReasonsRefusal(Long chatId) {
        sendMultipurpose(chatId, REASONS_REFUSAL_FIELD, REASONS_REFUSAL_NOT_FOUND);
    }
    
    *//**
     * @param chatId      Telegram chat id
     * @param areaField   column "area" in Data Base Table "Info"
     * @param notFoundMsg a message sent to the Telegram chat when there is no record with the areaField value
     *//*
    protected void sendMultipurpose(Long chatId, String areaField, String notFoundMsg) {
        Info info = infoService.findInfoByArea(areaField);
        //temporally disabled, just path
    }
    
    
    protected void sendMultipurpose(TgIn in, String areaField, String notFoundMsg) {
        Info info = infoService.findInfoByArea(areaField);
        TgOut out = new TgOut();
        out
                .tgIn(in)
                .generateMarkup(in.getCustomer().getCustomerContext().getCurLevel());
        if (info == null) {
        out
            .textBody(notFoundMsg);
        } else {
        out
            .textBody(info.getInstructions());
        }
        out
                .send()
                .save();
        
    }
*/
    // todo: deprecated
    /**
     * Метод обновляет значения полей "context"
     *
     * @param customer текущий пользователь
     * @param context  новое значение поля "context"
     */
    void updateCustomerContext(Customer customer, Context context) {
        CustomerContext customerContext = customer.getCustomerContext();
        customerContext.setDialogContext(context);
        customerService.updateCustomer(customer);
    }
    
}
